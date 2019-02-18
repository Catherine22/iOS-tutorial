//
//  URLSessionNetworkDispatcher.swift
//  IOOperations
//
//  Created by Catherine Chen (RD-TW) on 15/02/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import Foundation

struct URLSessionNetworkDispatcher: NetworkDispatcher {
    static let shared = URLSessionNetworkDispatcher()
    private init() {
        
    }

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
        
        URLSession.shared.dataTask(with: url) { (d, r, e) in
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
