//
//  NetworkManager.swift
//  IOOperations
//
//  Created by Catherine Chen (RD-TW) on 15/02/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager: SessionDelegate {
    
    var sessionManager: SessionManager?
    override init() {
        super.init()
        
        certificatePinning()
    }
    
    override func urlSession(_ session: URLSession, task: URLSessionTask, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
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
    
    private func certificatePinning() {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
        
        if Constants.shared.ARBITRARY_LOADS_ALLOWED {
            sessionManager = Alamofire.SessionManager(configuration: configuration, delegate: self, serverTrustPolicyManager: nil)
            return
        }
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
        
        let serverTrustPolicy = ServerTrustPolicy.pinCertificates(
            certificates: [SecCertificateCreateWithData(nil, localCertificate)!],
            validateCertificateChain: true,
            validateHost: true
        )
        
        let serverTrustPolicies = [
            Constants.shared.DOMAIN: serverTrustPolicy
        ]
        
        let serverTrustPolicyManager = ServerTrustPolicyManager(policies: serverTrustPolicies)
        sessionManager = Alamofire.SessionManager(configuration: configuration, delegate: self, serverTrustPolicyManager: serverTrustPolicyManager)
    }
}

extension NetworkManager {
    //MARK: Alamofire + SwiftyJSON
    func getReposByAloamofire() {
        // request parameters
        let params:[String: String] = [:]
        
        // It makes a request in the background
        sessionManager?.request(Constants.shared.URL, method: .get, parameters: params).responseJSON {
            response in
            // what should be triggered once the background processes has completed
            if response.result.isSuccess {
                let result: JSON = JSON(response.result.value!)
                print(result)
            } else {
                fatalError("Error: \(String(describing: response.result.error))")
            }
        }
    }
    
    //MARK: URLSession
    func getReposByURLSession() {
        GetRepos().execute(onSuccess: { (repos) in
            print(repos)
        }) { (errorType) in
            fatalError(errorType.errorMessage())
        }
    }
}
