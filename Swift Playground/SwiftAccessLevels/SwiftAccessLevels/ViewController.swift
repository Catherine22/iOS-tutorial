//
//  ViewController.swift
//  SwiftAccessLevels
//
//  Created by Catherine Chen (RD-TW) on 12/02/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let classA = ClassA()
        print("ClassA: \(classA.internalProperty)")
        
        let classB = ClassB()
        classB.showPropertiesFromClassA()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

