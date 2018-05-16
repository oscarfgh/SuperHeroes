//
//  SuperheroeResource.swift
//  SuperHeroes
//
//  Created by Oscar on 16/5/18.
//  Copyright © 2018 Oscar García. All rights reserved.
//

import Foundation
import Result

enum SuperheroesResource {
    case all
}

extension SuperheroesResource: Resource {
    
    var method: Method {
        switch self {
        case .all:
            return .GET
        }
    }
    
    var path: String {
        switch self {
        case .all:
            return ""
        }
    }
    
    var parameters: [String: String] {
        switch self {
        case .all:
            return [:]
        }
    }
    
    var body: Data? {
        switch self {
        case .all:
            return nil
        }
    }
}

extension URL {
    
    static func superheroeURL() -> URL {
        guard let baseURL = URL(string: AppURL.DomainsAPI.release) else {
            fatalError("API URL is needed")
        }
        return baseURL.appendingPathComponent("bvyob")
    }
}

extension APIClient {
    
    static func superheroesAPIClient() -> APIClient {
        return APIClient(baseURL: URL.superheroeURL())
    }
    
    func superheroes(completion: @escaping (Result<Superheroes, APIClientError>) -> Void) {
        let resource = SuperheroesResource.all
        object(resource) { (result: Result<Superheroes, APIClientError>) in
            completion(result)
        }
    }
}
