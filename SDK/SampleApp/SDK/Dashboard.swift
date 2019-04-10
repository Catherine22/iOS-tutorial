//
//  Dashboard.swift
//  SampleApp
//
//  Created by Catherine Chen (RD-TW) on 10/04/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import Foundation

public class Dashboard {
    public var TAG = "Dashboard"
    private var members: [Member]?
    
    public func getMembers() -> [Member]? {
        return members
    }
    
    public func addMember(_ member: Member) -> [Member] {
        Logger.shared.log(TAG, "new member: \(member)")
        func add(_ member: Member) -> [Member] {
            members?.append(member)
            return members!
        }
        if members == nil {
            members = []
        }
        return add(member)
    }
}
