//
//  SuperheroeResource.swift
//  SuperHeroes
//
//  Created by Oscar on 16/5/18.
//  Copyright © 2018 Oscar García. All rights reserved.
//

import Foundation
import Result

enum SuperheroeResource {
    case all
}

extension SuperheroeResource: Resource {
    
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
    
    static func cardContainerURL() -> URL {
        guard let baseURL = URL(string: AppURL.DomainsAPI.release) else {
            fatalError("API URL is needed")
        }
        return baseURL.appendingPathComponent("bvyob")
    }
}

extension APIClient {
    
    static func cardContainerAPIClient() -> APIClient {
        return APIClient(baseURL: URL.cardContainerURL())
    }
    
    func cardContainer(completion: @escaping (Result<[Superheroe], APIClientError>) -> Void) {
        let resource = SuperheroeResource.all
        object(resource) { (result: Result<[Superheroe], APIClientError>) in
            completion(result)
        }
    }
}
