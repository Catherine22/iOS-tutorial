//
//  Logger.swift
//  SDK
//
//  Created by Catherine Chen (RD-TW) on 10/04/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import Foundation

class Logger {
    static let shared = Logger()
    
    private init() {
        
    }
    
    func log (_ tag: String, _ message: String) {
        if Constants.shared.SHOW_LOG {
            NSLog(message)
        }
    }
}
