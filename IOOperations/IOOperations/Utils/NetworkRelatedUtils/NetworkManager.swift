//
//  NetworkManager.swift
//  IOOperations
//
//  Created by Catherine Chen (RD-TW) on 15/02/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager {
    let url = "https://jsonplaceholder.typicode.com/todos/1"
    
    //MARK: Alamofire + SwiftyJSON
    func getJsonPlaceholderByAloamofire() {
        let params:[String: String] = [:]
        
        // It makes a request in the background
        Alamofire.request(url, method: .get, parameters: params).responseJSON {
            response in
            // what should be triggered once the background processes has completed
            if response.result.isSuccess {
                let result: JSON = JSON(response.result.value!)
                print(result)
            } else {
                fatalError("Error: \(String(describing: response.result.error))")
            }
        }
    }
    
    //MARK: URLSession
    func getJsonPlaceholderByURLSession() {
        GetUser().execute(onSuccess: { (jsonPlaceHolder) in
            print(jsonPlaceHolder)
        }) { (errorType) in
            print(errorType.errorMessage())
        }
    }
}
