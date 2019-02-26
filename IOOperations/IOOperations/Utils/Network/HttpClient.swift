//
//  HttpClient
//  IOOperations
//
//  Created by Catherine Chen (RD-TW) on 15/02/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import Foundation
import Alamofire

class HttpClient: SessionDelegate {
    
    let TAG = "HttpClient"
    var sessionManager: SessionManager?
    var defaultHeaders: HTTPHeaders?
    var trustHost: String = Constants.shared.URL
    var urlCredential: URLCredential?
    override init() {
        super.init()
        config()
    }
    
    override func urlSession(_ session: URLSession, task: URLSessionTask, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if Constants.shared.ARBITRARY_LOADS_ALLOWED {
            super.urlSession(session, task: task, didReceive: challenge, completionHandler: completionHandler)
            return
        }
        
        if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
            guard let serverTrust = challenge.protectionSpace.serverTrust else {
                Logger.shared.error(TAG, CustomError(error: CustomError.ErrorTypes.CERTIFICATES_NOT_FOUND))
                return
            }
            
            var secresult = SecTrustResultType.invalid
            let status = SecTrustEvaluate(serverTrust, &secresult)
            if(errSecSuccess == status) {
                guard let serverCertificate = SecTrustGetCertificateAtIndex(serverTrust, 0) else {
                    Logger.shared.error(TAG, CustomError(error: CustomError.ErrorTypes.CERTIFICATES_NOT_FOUND))
                    return
                }
                
                let serverCertificateData = SecCertificateCopyData(serverCertificate)
                let data = CFDataGetBytePtr(serverCertificateData);
                let size = CFDataGetLength(serverCertificateData);
                let cert1 = NSData(bytes: data, length: size)
                
                
                guard let localCertificate = retrieveLocalCertificate() else {
                    return
                }
                
                let cert2 = localCertificate as Data
                if cert1.isEqual(to: cert2) {
                    urlCredential = URLCredential(trust:serverTrust)
                    completionHandler(URLSession.AuthChallengeDisposition.useCredential, urlCredential)
                    return
                }
            }
        } else if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodClientCertificate) {
            super.urlSession(session, task: task, didReceive: challenge, completionHandler: completionHandler)
            return
        }
        
        // Pinning failed
        completionHandler(URLSession.AuthChallengeDisposition.cancelAuthenticationChallenge, nil)
    }
    
    
    private func config() {
        defaultHeaders = [
            "User-Agent": "CustomAgent",
        ]
        
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
        
        if Constants.shared.ARBITRARY_LOADS_ALLOWED {
            sessionManager = Alamofire.SessionManager(configuration: configuration, delegate: self, serverTrustPolicyManager: nil)
            return
        }
        
        guard let localCertificate = retrieveLocalCertificate() else {
            return
        }
        
        let serverTrustPolicy = ServerTrustPolicy.pinCertificates(
            certificates: [SecCertificateCreateWithData(nil, localCertificate)!],
            validateCertificateChain: true,
            validateHost: true
        )
        
        let serverTrustPolicies = [
            trustHost: serverTrustPolicy
        ]
        
        let serverTrustPolicyManager = ServerTrustPolicyManager(policies: serverTrustPolicies)
        
        sessionManager = Alamofire.SessionManager(configuration: configuration, delegate: self, serverTrustPolicyManager: serverTrustPolicyManager)
    }
    
    private func retrieveLocalCertificate() -> NSData? {
        guard let bundlePath = Constants.shared.CERTIFICATES_PATH else {
            Logger.shared.error(TAG, CustomError(error: CustomError.ErrorTypes.CERTIFICATES_NOT_FOUND))
            return nil
        }
        
        let bundle = Bundle(path: bundlePath)
        guard let crtPath = bundle?.url(forResource: Constants.shared.CERTIFICATE, withExtension: Constants.shared.CERTIFICATES_FILE_TYPE) else {
            Logger.shared.error(TAG, CustomError(error: CustomError.ErrorTypes.CERTIFICATES_NOT_FOUND))
            return nil
        }
        
        guard let localCertificate = NSData(contentsOf: crtPath) else {
            Logger.shared.error(TAG, CustomError(error: CustomError.ErrorTypes.CERTIFICATES_NOT_FOUND))
            return nil
        }
        
        return localCertificate
    }
    
    func refreshHeaders(method: HTTPMethod, hasParameters: Bool, additionalHeaders: [String: String]?) -> HTTPHeaders {
        var newHeaders = defaultHeaders
        if newHeaders == nil {
            return [:]
        }
        
        if method == .post && hasParameters {
            newHeaders!["Content-Type"] = "application/json"
        }
        
        if additionalHeaders != nil {
            for (key, value) in additionalHeaders! {
                newHeaders![key] = value
            }
        }
        
        return newHeaders!
    }
}

extension HttpClient {
    
    func get(urlBuilder: URLBuilder, params: [String: String]?, headers: [String: String]?) throws -> DataRequest? {
        trustHost = urlBuilder.host
        let httpMethod = HTTPMethod.get
        let headers = refreshHeaders(method: httpMethod, hasParameters: false, additionalHeaders: headers)
        guard let url = urlBuilder.build(params: params) else {
            throw CustomError.ErrorTypes.INVALID_PATH
        }
        return sessionManager?.request(url, method: httpMethod, parameters: nil, encoding: URLEncoding.default, headers: headers)
    }
    
    func post(urlBuilder: URLBuilder, params: [String: Any]?, headers: [String: String]?) throws -> DataRequest? {
        trustHost = urlBuilder.host
        let parameters:[String: Any] = params ?? [:]
        let httpMethod = HTTPMethod.post
        let headers = refreshHeaders(method: httpMethod, hasParameters: parameters.count > 0, additionalHeaders: headers)
        guard let url = urlBuilder.build() else {
            throw CustomError.ErrorTypes.INVALID_PATH
        }
        
        let request = sessionManager?.request(url, method: httpMethod, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        //        print("request:\(request.debugDescription)")
        return request
    }
}
