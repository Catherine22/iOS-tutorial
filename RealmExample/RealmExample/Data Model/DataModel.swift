//
//  DataModel.swift
//  RealmExample
//
//  Created by Catherine Chen (RD-TW) on 16/01/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import Foundation
import RealmSwift

class DataModel: Object {
    // dynamic is a declaration modifier, it basically tells the runtime to use dynamic dispatch over the standard which is a static dispatch.This allows the property "name" to be monitered for change at runtime.
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0
}
