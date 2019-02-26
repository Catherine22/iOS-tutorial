//
//  NetworkDispatcher.swift
//  IOOperations
//
//  Created by Catherine Chen (RD-TW) on 18/02/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import Foundation

protocol NetworkDispatcher {
    func dispatch(request: RequestModel, onSuccess: @escaping (Data) -> Void, onError: @escaping (Constants.ErrorTypes) -> Void)
}
