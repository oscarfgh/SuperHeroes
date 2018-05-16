//
//  APIClient.swift
//  SuperHeroes
//
//  Created by Oscar on 16/5/18.
//  Copyright © 2018 Oscar García. All rights reserved.
//

import Foundation
import Result

typealias HTTPStatusCode = Int

final class APIClient {
    
    struct APIClientResponse {
        
        let httpStatusCode: HTTPStatusCode
        let body: Data
    }
    
    private let baseURL: URL
    private var session: URLSession
    
    private var isNetworkActivityIndicatorVisible: Bool = false {
        didSet {
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = self.isNetworkActivityIndicatorVisible
            }
        }
    }
    
    init(baseURL: URL,
         configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        self.baseURL = baseURL
        self.session = URLSession(configuration: configuration)
    }
    
    func object<T: Decodable>(_ resource: Resource, completion: @escaping(Result<T, APIClientError>) -> Void) {
        data(resource) { (result: Result) in
            if let error = result.error {
                completion(Result(error: error))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            guard
                let value = result.value?.body,
                let object:T = try? jsonDecoder.decode(T.self, from: value) else {
                    print(APIClientError.parsingError.description)
                    completion(Result(error: .parsingError))
                    return
            }
            
            completion(Result(value: object))
        }
    }
    
    func status(_ resource: Resource, completion: @escaping(Result<HTTPStatusCode, APIClientError>) -> Void) {
        data(resource) { (result: Result) in
            switch result {
            case .success(let response):
                completion(Result(value: response.httpStatusCode))
            case .failure(let error):
                completion(Result(error: error))
            }
        }
    }
    
    // MARK: - Private
    
    private func data(_ resource: Resource, completion: @escaping(Result<APIClientResponse, APIClientError>) -> Void) {
        isNetworkActivityIndicatorVisible = true
        
        let request = resource.requestWithBaseURL(baseURL)
        
        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            self.isNetworkActivityIndicatorVisible = false
            if let error = error {
                completion(Result(error: APIClientError.httpClientError(error: error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(Result(error: .networkError))
                return
            }
            
            let bodyData = data ?? Data()
            
            if (200 ..< 300 ~= httpResponse.statusCode) {
                print("Status response: \(httpResponse.statusCode)")
                print("JSON response: \n\(bodyData.jsonString)")
                let response = APIClientResponse(httpStatusCode: httpResponse.statusCode, body: bodyData)
                completion(Result(value: response))
            } else {
                print("Error: \(httpResponse.statusCode)")
                completion(Result(error: APIClientError.httpResponseError(statusCode: httpResponse.statusCode)))
            }
        }
        task.resume()
    }
}
