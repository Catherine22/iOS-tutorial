//
//  TodoeyItem.swift
//  Todoey
//
//  Created by Catherine Chen (RD-TW) on 2018/12/7.
//  Copyright © 2018 Catherine Chen. All rights reserved.
//

import Foundation

// Solution 1: UserDefault
// Solution 2: FileManager
class TodoeyItem: Codable {
    var title: String
    var done: Bool
    
    init(title: String, done: Bool) {
        self.title = title
        self.done = done
    }
    
    // Solution 1: UserDefault
    // Deprecated: No need to encode/decode to JSON/Object to save data
//    func toString() -> String? {
//        do {
//            let jsonEncoder = JSONEncoder()
//            let jsonData = try jsonEncoder.encode(self)
//            return String(data: jsonData, encoding: .utf8)
//        } catch {
//            print("Could not convert TodoeyItem to JSON String")
//        }
//        return nil
//    }
//
//    static func toObject(todoeyItemString: String) -> TodoeyItem? {
//        do {
//            let jsonDecoder = JSONDecoder()
//            if let data: Data = todoeyItemString.data(using: .utf8) {
//                return try jsonDecoder.decode(TodoeyItem.self, from: data)
//            }
//        } catch {
//            print("Could not convert String to Object")
//        }
//        return nil
//    }
}
