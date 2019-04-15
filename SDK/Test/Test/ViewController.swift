//
//  ViewController.swift
//  Test
//
//  Created by Catherine Chen (RD-TW) on 15/04/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import UIKit
import SDK

class ViewController: UIViewController {
    var members: [Member]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Constants.shared.SHOW_LOG = false
        let dashboard = Dashboard()
        
        let john = Member(name: "John", age: 10)
        members = dashboard.addMember(john)
        print(members!)
        
        
        let matthew = Member(name: "Matthew", age: 12)
        members = dashboard.addMember(matthew)
        print(dashboard.getMembers()!)
    }


}

