//
//  MyTodoeyItem.swift
//  TodoeyWithRealm
//
//  Created by Catherine Chen (RD-TW) on 2018/12/27.
//  Copyright © 2018 Catherine Chen. All rights reserved.
//

import Foundation
import RealmSwift

class MyTodoeyItem: Object {
    // dynamic is what's called a declaration modifier, it basically tells the runtime to use dynamic dispatch over the standard, which is static dispatch. This allows the property the be monitored for change at runtime, i.e. If the user change the value of title for example while the app is running, that allows Realm to dynamically update the changes in the database.
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
