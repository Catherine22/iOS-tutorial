//
//  Catagory.swift
//  RealmExample
//
//  Created by Catherine Chen (RD-TW) on 29/01/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
