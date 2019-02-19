//
//  GetUser.swift
//  IOOperations
//
//  Created by Catherine Chen (RD-TW) on 18/02/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import Foundation

struct GetWeather: RequestType {
    typealias ResponseType = Weather
    let requestModel = RequestModel(path: Constants.shared.URL)
}
