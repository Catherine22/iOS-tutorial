//
//  Constants.swift
//  IOOperations
//
//  Created by Catherine Chen (RD-TW) on 18/02/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import Foundation

class Constants {
    static let shared = Constants()
    
    var SHOW_LOG = true
    var KEEP_LOG = true
    
    enum ErrorTypes {
        case INVALID_PATH
        case FAILED_TO_SERIALISE
        case FAILED_TO_DECODE_JSON
        case NIL_RESPONSE_DATA
        case URL_SESSION_FAILED
        case CERTIFICATES_NOT_FOUND
        
        case httpError(Int, String)
        
        func errorMessage() -> String {
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
            default:
                return "Undefined Error"
            }
        }
    }
    
    let ARBITRARY_LOADS_ALLOWED = false // must syncronise this value to info.plist as well
    let URL_SCHEME = "https"
    let URL = "api.github.com"
    let PATH = (
        USERS: "users",
        ALAMOFIRE: "Alamofire",
        REPOS: "repos"
    )
    let CERTIFICATES_PATH = Bundle.main.path(forResource: "Certificates", ofType: "bundle")
    let CERTIFICATE = "github"
    let CERTIFICATES_FILE_TYPE = "crt"
}
