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
    
    //MARK: Alamofire + SwiftyJSON
    func getJsonPlaceholderByAloamofire() {
        // request parameters
        let params:[String: String] = [:]
        
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

        let serverTrustPolicy = ServerTrustPolicy.pinCertificates(
            certificates: [SecCertificateCreateWithData(nil, localCertificate)!],
            validateCertificateChain: true,
            validateHost: true
        )
        
        let serverTrustPolicies = [
            Constants.shared.DOMAIN: serverTrustPolicy
        ]
        
        let serverTrustPolicyManager = ServerTrustPolicyManager(policies: serverTrustPolicies)
        let sessionManager = Alamofire.SessionManager(configuration: URLSessionConfiguration.default, delegate: self, serverTrustPolicyManager: serverTrustPolicyManager)
        
        
        // It makes a request in the background
        sessionManager.request(Constants.shared.URL, method: .get, parameters: params).responseJSON {
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
    func getJsonPlaceholderByURLSession() {
        GetUser().execute(onSuccess: { (jsonPlaceHolder) in
            print(jsonPlaceHolder)
        }) { (errorType) in
            fatalError(errorType.errorMessage())
        }
    }
}
