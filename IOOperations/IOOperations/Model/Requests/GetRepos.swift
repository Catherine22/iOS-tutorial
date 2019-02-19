//
//  GetUser.swift
//  IOOperations
//
//  Created by Catherine Chen (RD-TW) on 19/02/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import Foundation

struct GetRepos: RequestType {
    typealias ResponseType = Repo
    let requestModel = RequestModel(path: Constants.shared.URL)
}
