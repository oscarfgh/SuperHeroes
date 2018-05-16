//
//  Data.swift
//  SuperHeroes
//
//  Created by Oscar on 16/5/18.
//  Copyright © 2018 Oscar García. All rights reserved.
//

import Foundation

extension Data {
    
    var jsonString: String {
        guard
            let json = try? JSONSerialization.jsonObject(with: self, options: []),
            let data = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
            let string = String(data: data, encoding: String.Encoding.utf8) else {
                return ""
        }
        return string
    }
}
