//
//  APIClientError.swift
//  SuperheroesTests
//
//  Created by Oscar on 17/5/18.
//  Copyright © 2018 Oscar García. All rights reserved.
//

import Foundation

@testable import Superheroes

extension APIClientError: Equatable {
    
    static public func == (lhs: APIClientError, rhs: APIClientError) -> Bool {
        switch (lhs, rhs) {
        case (.networkError, .networkError):
            return true
        case (.parsingError, .parsingError):
            return true
        case let (.httpResponseError(code1), .httpResponseError(code2)):
            return code1 == code2
        case let (.httpClientError(error1), .httpClientError(error2)):
            return error1._code == error2._code
        default:
            return false
        }
    }
}
