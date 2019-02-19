//
//  RequestType.swift
//  IOOperations
//
//  Created by Catherine Chen (RD-TW) on 15/02/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import Foundation

protocol RequestType {
    associatedtype ResponseType: Codable
    var requestModel: RequestModel { get }
}

extension RequestType {
    func execute (dispatcher: NetworkDispatcher = URLSessionNetworkDispatcher.shared, onSuccess: @escaping (ResponseType) -> Void, onError: @escaping (Constants.ErrorTypes) -> Void
        ) {
        dispatcher.dispatch(request: self.requestModel, onSuccess: { (response) in
            print("response:\(response)")
            do {
                let jsonDecoder = JSONDecoder()
                let rawData = try jsonDecoder.decode(ResponseType.self, from: response)
                DispatchQueue.main.async {
                    onSuccess(rawData)
                }
            } catch {
                onError(Constants.ErrorTypes.FAILED_TO_DECODE_JSON)
            }
        }) { (error) in
            onError(Constants.ErrorTypes.FAILED_TO_DECODE_JSON)
        }
    }
}
