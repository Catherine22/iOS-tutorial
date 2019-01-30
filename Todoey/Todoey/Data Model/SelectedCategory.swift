//
//  SelectedCategory.swift
//  Todoey
//
//  Created by Catherine Chen (RD-TW) on 2018/12/26.
//  Copyright © 2018 Catherine Chen. All rights reserved.
//

import Foundation

class SelectedCategory {
    var category: Category?
    var queryAll: Bool
    
    init(category: Category?, queryAll: Bool) {
        self.category = category
        self.queryAll = queryAll
    }
}
