//
//  ViewController.swift
//  IOOperations
//
//  Created by Catherine Chen (RD-TW) on 15/02/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let networkManager = NetworkManager()
        networkManager.getJsonPlaceholderByAloamofire()
        networkManager.getJsonPlaceholderByURLSession()
    }
}

