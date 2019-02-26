//
//  GithubModule.swift
//  IOOperations
//
//  Created by Catherine Chen (RD-TW) on 26/02/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import Foundation

class GithubModule {
    var httpClient: HttpClient?
    var onFail: ((CustomError) -> Void)?
    
    init() {
        httpClient = HttpClient()
    }
    public func getAlamofireRepo(onSuccess: @escaping () -> Void, onFail: ((CustomError) -> Void)?) {
        self.onFail = onFail
        
        let path = [Constants.shared.PATH.USERS, Constants.shared.PATH.ALAMOFIRE, Constants.shared.PATH.REPOS]
        let urlBuilder = URLBuilder(host: Constants.shared.URL, path: path)
        
        do {
            try httpClient?.get(urlBuilder: urlBuilder, params: nil, headers: nil)?.responseRepo(completionHandler: { (response) in
                
                if !self.verifyResponse(error: response.error, httpURLResponse: response.response) {
                    return
                }
                
                guard let description = response.value?.description else {
                    var customError = CustomError(error: CustomError.ErrorTypes.ERROR_RESPONSE)
                    customError.message = "Invalid description"
                    DispatchQueue.main.async {
                        self.onFail?(customError)
                    }
                    return
                }
                
                print("description: \(description)")
                onSuccess()
            })
        } catch {
            DispatchQueue.main.async {
                let error = CustomError.init(error: CustomError.ErrorTypes.ERROR_RESPONSE, message: "\(error)")
                self.onFail?(error)
            }
        }
    }
    
    private func verifyResponse(error: Error?, httpURLResponse: HTTPURLResponse?) -> Bool {
        if error != nil {
            var customError = CustomError(error: CustomError.ErrorTypes.ERROR_RESPONSE)
            customError.message = error!.localizedDescription
            DispatchQueue.main.async {
                self.onFail?(customError)
            }
            return false
        }
        
        guard let statusCode = httpURLResponse?.statusCode else {
            var customError = CustomError(error: CustomError.ErrorTypes.ERROR_RESPONSE)
            customError.message = "No status code"
            DispatchQueue.main.async {
                self.onFail?(customError)
            }
            return false
        }
        
        if statusCode != 200 {
            var customError = CustomError(error: CustomError.ErrorTypes.ERROR_RESPONSE)
            customError.code = statusCode
            customError.message = httpURLResponse?.description
            DispatchQueue.main.async {
                self.onFail?(customError)
            }
            return false
        }
        
        return true
    }
}
