//
//  RequestModel.swift
//  IOOperations
//
//  Created by Catherine Chen (RD-TW) on 15/02/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import Foundation

struct RequestModel {
    var path: String?
    var method: HTTPMethod?
    var params: [String: String?]?
    var headers: [String: String]?
    
    init (path: String) {
        self.path = path
    }
}

enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case HEAD = "HEAD"
    case DELETE = "DELETE"
    case PATCH = "PATCH"
    case TRACE = "TRACE"
    case OPTIONS = "OPTIONS"
    case CONNECT = "CONNECT"
}
