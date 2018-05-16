//
//  Resource.swift
//  SuperHeroes
//
//  Created by Oscar on 16/5/18.
//  Copyright © 2018 Oscar García. All rights reserved.
//

import Foundation

enum Method: String {
    case GET = "GET"
    case POST = "POST"
    case PATCH = "PATCH"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

protocol Resource {
    
    var method: Method { get }
    var path: String { get }
    var parameters: [String: String] { get }
    var body: Data? { get }
    var contentType: String? { get }
}

extension Resource {
    
    var method: Method {
        return .GET
    }
    var parameters: [String: String] {
        return [:]
    }
    var body: Data? {
        return nil
    }
    var contentType: String? {
        return "application/json"
    }
    
    func requestWithBaseURL(_ baseURL: URL) -> URLRequest {
        let url = !path.isEmpty ? baseURL.appendingPathComponent(path) : baseURL
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            let description = "Unable to create URL components from \(url)"
            print(description)
            fatalError(description)
        }
        
        components.queryItems = parameters.map {
            URLQueryItem(name: String($0), value: String($1))
        }
        
        guard let finalURL = components.url else {
            let description = "Unable to retrieve final URL"
            print(description)
            fatalError(description)
        }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        
        if let body = self.body {
            request.httpBody = body
            
            print("JSON body : \n" + body.jsonString)
        }
        
        if let contentType = self.contentType {
            request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        }
        print("\(request.httpMethod ?? "") -> \(url)")
        
        return request
    }
}
