//
//  URLSessionNetworkDispatcher.swift
//  IOOperations
//
//  Created by Catherine Chen (RD-TW) on 15/02/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import Foundation
import Security

// TODO check if delegate works
class URLSessionNetworkDispatcher: NSObject, URLSessionDelegate {
    static let shared = URLSessionNetworkDispatcher()
    
    // MARK: Handling authentication changes (https://developer.apple.com/documentation/foundation/url_loading_system/handling_an_authentication_challenge)
    // Not working (https://stackoverflow.com/questions/26268445/authentication-challenge-method-is-not-called-when-using-nsurlsession-custom-del)
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        print("dddd [URLSessionDelegate] didReceive challenge")
        setAuthentication(session, didReceive: challenge, completionHandler: completionHandler)
    }
    
    private func setAuthentication(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        //Reference: https://stackoverflow.com/questions/34223291/ios-certificate-pinning-with-swift-and-nsurlsession
        if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
            guard let serverTrust = challenge.protectionSpace.serverTrust else {
                Logger.shared.error(Constants.ErrorTypes.CERTIFICATES_NOT_FOUND.errorMessage())
                return
            }
            
            
            var secresult = SecTrustResultType.invalid
            let status = SecTrustEvaluate(serverTrust, &secresult)
            if(errSecSuccess == status) {
                guard let serverCertificate = SecTrustGetCertificateAtIndex(serverTrust, 0) else {
                    Logger.shared.error(Constants.ErrorTypes.CERTIFICATES_NOT_FOUND.errorMessage())
                    return
                }
                
                let serverCertificateData = SecCertificateCopyData(serverCertificate)
                let data = CFDataGetBytePtr(serverCertificateData);
                let size = CFDataGetLength(serverCertificateData);
                let cert1 = NSData(bytes: data, length: size)
                
                // certificates pinning
                guard let bundlePath = Constants.shared.CERTIFICATES_PATH else {
                    Logger.shared.error(Constants.ErrorTypes.CERTIFICATES_NOT_FOUND.errorMessage())
                    return
                }
                
                let bundle = Bundle(path: bundlePath)
                guard let crtPath = bundle?.url(forResource: Constants.shared.CERTIFICATES[0], withExtension: Constants.shared.CERTIFICATES_FILE_TYPE) else {
                    Logger.shared.error(Constants.ErrorTypes.CERTIFICATES_NOT_FOUND.errorMessage())
                    return
                }
                
                guard let localCertificate = NSData(contentsOf: crtPath) else {
                    Logger.shared.error(Constants.ErrorTypes.CERTIFICATES_NOT_FOUND.errorMessage())
                    return
                }
                
                if cert1.isEqual(to: localCertificate as Data) {
                    completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust:serverTrust))
                    return
                }
            }
        }
        
        // Pinning failed
        completionHandler(URLSession.AuthChallengeDisposition.cancelAuthenticationChallenge, nil)
    }
}

extension URLSessionNetworkDispatcher: NetworkDispatcher {

    func dispatch(request: RequestModel, onSuccess: @escaping (Data) -> Void, onError: @escaping (Constants.ErrorTypes) -> Void) {
        
        guard let path = request.path, let url = URL(string: path) else {
            onError(Constants.ErrorTypes.INVALID_PATH)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method?.rawValue ?? HTTPMethod.GET.rawValue
        
        
        if let params = request.params {
            do {
                // TODO GET params
                urlRequest.httpBody =  try JSONSerialization.data(withJSONObject: params, options: [])
            } catch {
                onError(Constants.ErrorTypes.FAILED_TO_SERIALISE)
                return
            }
        }
        
        let configuration = URLSession.shared.configuration
        configuration.requestCachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
        
//        let urlSession = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        let urlSession = URLSession(configuration: configuration)
        
        urlSession.dataTask(with: url) { (d, r, e) in
            if let error = e {
                Logger.shared.error("\(error)")
                onError(Constants.ErrorTypes.URL_SESSION_FAILED)
                return
            }
            
            guard let data = d else {
                onError(Constants.ErrorTypes.NIL_RESPONSE_DATA)
                return
            }
            
            // check code like 500 here
            onSuccess(data)
            
            }.resume()
    }
    
}
