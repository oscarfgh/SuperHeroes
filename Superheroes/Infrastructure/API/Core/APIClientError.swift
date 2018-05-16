//
//  APIClientError.swift
//  SuperHeroes
//
//  Created by Oscar on 16/5/18.
//  Copyright © 2018 Oscar García. All rights reserved.
//

import Foundation

enum APIClientError: Error {
    case httpResponseError(statusCode: Int)
    case httpClientError(error: Error)
    case networkError
    case parsingError
}

extension APIClientError: CustomStringConvertible {
    
    var description: String {
        switch self {
        case .httpResponseError(let statusCode):
            return "Response Error: \(statusCode)"
        case .httpClientError(let error):
            return "HTTP Client Error \(error)"
        case .networkError:
            return "Network Error!"
        case .parsingError:
            return "Parsing Error!"
        }
    }
}

extension APIClientError: CustomDebugStringConvertible {
    
    var debugDescription: String {
        return description
    }
}
