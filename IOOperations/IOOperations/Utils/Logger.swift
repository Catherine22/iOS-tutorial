//
//  Logger.swift
//  IOOperation
//
//  Created by Catherine Chen (RD-TW) on 19/02/2019.
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
        persistant(message)
    }
    
    func error (_ tag: String, _ error: CustomError) {
        if Constants.shared.SHOW_LOG {
            NSLog("error: \(error)")
        }
        persistant("error: \(error)")
    }
    
    private func persistant(_ message: String) {
        if Constants.shared.KEEP_LOG {
            // save logs
        }
    }
}
