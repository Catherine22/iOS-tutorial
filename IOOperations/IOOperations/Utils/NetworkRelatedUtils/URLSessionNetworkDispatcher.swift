//
//  URLSessionNetworkDispatcher.swift
//  IOOperations
//
//  Created by Catherine Chen (RD-TW) on 15/02/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import Foundation
import Security

class URLSessionNetworkDispatcher: NSObject, URLSessionDelegate {
    static let shared = URLSessionNetworkDispatcher()
    var urlSession: URLSession?
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
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
        
        // TODO: Set headers
        urlRequest.addValue("en;q=1.0", forHTTPHeaderField: "Accept-Language")
        urlRequest.addValue("gzip;q=1.0, compress;q=0.5", forHTTPHeaderField: "Accept-Encoding")
        urlRequest.addValue("IOOperations/1.0 (com.CBB.IOOperations; build:1; iOS 12.1.0)", forHTTPHeaderField: "User-Agent")
        urlRequest.addValue("text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8", forHTTPHeaderField: "Accept")
        
        // TODO: Set methods
        urlRequest.httpMethod = request.method?.rawValue ?? HTTPMethod.GET.rawValue
        
        // TODO: Set body
        if let params = request.params {
            do {
                // TODO GET params
                urlRequest.httpBody =  try JSONSerialization.data(withJSONObject: params, options: [])
            } catch {
                onError(Constants.ErrorTypes.FAILED_TO_SERIALISE)
                return
            }
        }
        
        // TODO: Set URLSession configuration
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
        if Constants.shared.ARBITRARY_LOADS_ALLOWED {
            urlSession = URLSession(configuration: configuration)
        } else {
            urlSession = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        }
        
        // TODO: Connect
        urlSession?.dataTask(with: urlRequest, completionHandler: { (data, urlResponse, error) in
            if let _error = error {
                Logger.shared.error("\(_error)")
                onError(Constants.ErrorTypes.URL_SESSION_FAILED)
                return
            }

            guard let _data = data else {
                onError(Constants.ErrorTypes.NIL_RESPONSE_DATA)
                return
            }

            guard let httpUrlResponse = urlResponse as? HTTPURLResponse else {
                onError(Constants.ErrorTypes.NIL_RESPONSE_DATA)
                return
            }

            let statusCode = httpUrlResponse.statusCode
            if (statusCode != 200) {
                onError(Constants.ErrorTypes.httpError(statusCode, httpUrlResponse.description))
                return
            }

            print(_data)
            onSuccess(_data)
        }).resume()
    }

}
