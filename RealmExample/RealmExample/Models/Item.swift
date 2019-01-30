//
//  Item.swift
//  RealmExample
//
//  Created by Catherine Chen (RD-TW) on 29/01/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    // dynamic is a declaration modifier, it basically tells the runtime to use dynamic dispatch over the standard which is a static dispatch.This allows the property "name" to be monitered for change at runtime.
    @objc dynamic var name: String = ""
    @objc dynamic var dateCreated: Date?
    
    // If we just simpily wrote "Category", then this is just a class. In order to make it the type of "Category", we have to say ",self"
    // property: what the parent list named in Category
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
