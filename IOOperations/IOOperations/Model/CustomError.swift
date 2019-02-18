//
//  CustomError.swift
//  IOOperations
//
//  Created by Catherine Chen (RD-TW) on 15/02/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import Foundation

struct CustomError {
    var title: String?
    var message: String?
    var errorCode: Int?
    var error: Error?
    
    init(title: String?, message: String?, errorCode: Int?, error: Error) {
        self.title = title
        self.message = message
        self.errorCode = errorCode
        self.error = error
    }
    
    init(title: String?, message: String?, errorCode: Int?) {
        self.title = title
        self.message = message
        self.errorCode = errorCode
    }
    
    init(error: Error?) {
        self.error = error
    }
}
