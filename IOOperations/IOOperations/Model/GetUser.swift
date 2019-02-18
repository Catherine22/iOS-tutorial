//
//  GetUser.swift
//  IOOperations
//
//  Created by Catherine Chen (RD-TW) on 18/02/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import Foundation

struct GetUser: RequestType {
    typealias ResponseType = Jsonplaceholder
    let requestModel = RequestModel(path: "https://jsonplaceholder.typicode.com/todos/1")
}
