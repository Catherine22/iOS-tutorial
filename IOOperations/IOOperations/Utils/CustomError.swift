//
//  CustomError.swift
//  IOOperations
//
//  Created by Catherine Chen (RD-TW) on 26/02/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import Foundation

public struct CustomError {
    public var code: Int?
    public var name: String
    public var message: String?
    
    public init(code: Int, name: String, message: String?) {
        self.code = code
        self.name = name
        self.message = message
    }
    
    public init(error: ErrorTypes) {
        self.code = error.code()
        self.name = error.name()
        self.message = error.message()
    }
    
    public init(error: ErrorTypes, message: String) {
        self.init(error: error)
        self.message = message
    }
    
    public enum ErrorTypes: Error {
        
        case INVALID_PATH
        case FAILED_TO_SERIALISE
        case FAILED_TO_DECODE_JSON
        case NIL_RESPONSE_DATA
        case URL_SESSION_FAILED
        case CERTIFICATES_NOT_FOUND
        case ERROR_RESPONSE
        
        public func message() -> String {
            switch self {
            case .INVALID_PATH:
                return "Invalid URL path"
            case .FAILED_TO_SERIALISE:
                return "Failed to serialise http request body"
            case .FAILED_TO_DECODE_JSON:
                return "Failed to decode json data"
            case .NIL_RESPONSE_DATA:
                return "Nil response data"
            case .URL_SESSION_FAILED:
                return "URLSession error"
            case .CERTIFICATES_NOT_FOUND:
                return "Certificates not found"
            case .ERROR_RESPONSE:
                return "Error response"
            }
        }
        
        public func name() -> String {
            switch self {
            case .INVALID_PATH:
                return "INVALID_PATH"
            case .FAILED_TO_SERIALISE:
                return "FAILED_TO_SERIALISE"
            case .FAILED_TO_DECODE_JSON:
                return "FAILED_TO_DECODE_JSON"
            case .NIL_RESPONSE_DATA:
                return "NIL_RESPONSE_DATA"
            case .URL_SESSION_FAILED:
                return "URL_SESSION_FAILED"
            case .CERTIFICATES_NOT_FOUND:
                return "CERTIFICATES_NOT_FOUND"
            case .ERROR_RESPONSE:
                return "ERROR_RESPONSE"
            }
        }
        
        public func code() -> Int {
            switch self {
            case .INVALID_PATH:
                return 1001
            case .FAILED_TO_SERIALISE:
                return 1002
            case .FAILED_TO_DECODE_JSON:
                return 1003
            case .NIL_RESPONSE_DATA:
                return 1004
            case .URL_SESSION_FAILED:
                return 1005
            case .CERTIFICATES_NOT_FOUND:
                return 1006
            case .ERROR_RESPONSE:
                return 1007
            }
        }
    }
}
