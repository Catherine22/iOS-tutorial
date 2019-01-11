//
//  Category.swift
//  TodoeyWithRealm
//
//  Created by Catherine Chen (RD-TW) on 2018/12/27.
//  Copyright © 2018 Catherine Chen. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<MyTodoeyItem>()
}
