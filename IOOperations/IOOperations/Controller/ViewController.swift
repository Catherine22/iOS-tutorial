//
//  ViewController.swift
//  IOOperations
//
//  Created by Catherine Chen (RD-TW) on 15/02/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    let url = "https://jsonplaceholder.typicode.com/todos/1"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //MARK: Alamofire + SwiftyJSON
        let params:[String: String] = [:]
        getByAloamofire(url: url, parameters: params)
        
        //MARK: URLSession
        getByURLSession()
    }
    
    func getByAloamofire(url: String, parameters: [String: String]) {
        // It makes a request in the background
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
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
    
    func getByURLSession() {
        GetUser().execute(onSuccess: { (jsonPlaceHolder) in
            print(jsonPlaceHolder)
        }) { (errorType) in
            print(errorType.errorMessage())
        }
    }
}

