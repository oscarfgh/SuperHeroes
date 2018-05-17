//
//  NSError.swift
//  SuperheroesTests
//
//  Created by Oscar on 17/5/18.
//  Copyright © 2018 Oscar García. All rights reserved.
//

import Foundation

extension NSError {
    
    static func networkError() -> NSError {
        return NSError(domain: NSURLErrorDomain,
                       code: NSURLErrorNetworkConnectionLost,
                       userInfo: nil)
    }
    
    static func itemNotFoundError() -> NSError {
        return NSError(domain: NSURLErrorDomain,
                       code: 404,
                       userInfo: nil)
    }
}

