//
//  URLBuilder.swift
//  IOOperations
//
//  Created by Catherine Chen (RD-TW) on 26/02/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import Foundation

class URLBuilder {
    var host: String
    var path: String = ""
    
    init(host: String, path: [String]?) {
        self.host = host.replacingOccurrences(of: "\\s", with: "", options: .regularExpression)
        if self.host.last == "/" {
            self.host.removeLast()
        }
        path?.forEach({ (p) in
            var temp = p.replacingOccurrences(of: "\\s", with: "", options: .regularExpression)
            if temp.first == "/" {
                temp.removeFirst()
            }
            
            self.path.append("/")
            self.path.append(temp)
        })
    }
    
    func build() -> String? {
        return build(params: nil)
    }
    
    func build(params: [String: String]?) -> String? {
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.shared.URL_SCHEME
        urlComponents.host = host
        urlComponents.path = self.path
        if params != nil && params!.count > 0 {
            var urlQueryItems: [URLQueryItem] = []
            for (key, value) in params! {
                urlQueryItems.append(URLQueryItem(name: key, value: value))
            }
            urlComponents.queryItems = urlQueryItems
        }
        guard let url = urlComponents.url else {
            return nil
        }
        return url.absoluteString.decodeUrl()
    }
}

extension String {
    func encodeUrl() -> String? {
        return self.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
    }
    func decodeUrl() -> String? {
        return self.removingPercentEncoding
    }
}
