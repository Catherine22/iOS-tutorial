//
//  ClassA.swift
//  SwiftAccessLevels
//
//  Created by Catherine Chen (RD-TW) on 12/02/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import Foundation

class ClassA {
    private let privateProperty = "privateProperty"
    fileprivate let fileprivateProperty = "fileprivateProperty"
    let internalProperty = "internalProperty"
}

class ClassB {
    func showPropertiesFromClassA() {
        let classA = ClassA()
        print("ClassB: \(classA.fileprivateProperty)")
        print("ClassB: \(classA.internalProperty)")
    }
}
