//
//  Logger.swift
//  IOOperations
//
//  Created by Catherine Chen (RD-TW) on 18/02/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import Foundation

class Logger {
    static let shared = Logger()
    
    private init() {
        
    }
    
    func log (_ tag: String, _ message: String) {
        log("[\(tag)] \(message)")
    }
    
    func log (_ message: String) {
        if Constants.shared.SHOW_LOG {
            NSLog(message)
        }
        persistant(message)
    }
    
    func error (_ tag: String, _ message: String) {
        error("[\(tag)] \(message)")
    }
    
    func error (_ message: String) {
        if Constants.shared.SHOW_LOG {
            NSLog("error: \(message)")
        }
        persistant(message)
    }
    
    func persistant(_ message: String) {
        if Constants.shared.KEEP_LOG {
            // save logs
        }
    }
}
