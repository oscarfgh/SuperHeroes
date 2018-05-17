//
//  APIClientTests.swift
//  SuperheroesTests
//
//  Created by Oscar on 17/5/18.
//  Copyright © 2018 Oscar García. All rights reserved.
//

import Foundation
import OHHTTPStubs
import Nimble
import Result
import XCTest

@testable import Superheroes


class APIClientTests: XCTestCase {
    
    struct TestModel: Decodable {
        
        let foo: String
    }
    
    struct TestResource: Resource {
        
        let path: String = "object"
        let parameters: [String: String] = ["testing": "true"]
    }
    
    var client: APIClient?
    
    override func setUp() {
        super.setUp()
        
        guard let url = URL(string: "http://test.com") else {
            XCTFail("URL is needed")
            return
        }
        
        client = APIClient(baseURL: url)
    }
    
    override func tearDown() {
        OHHTTPStubs.removeAllStubs()
        super.tearDown()
    }
    
    func testValidResponse() {
        stub(condition: isHost("test.com")) { _ in
            guard let stubPath = OHPathForFile("test.json", type(of: self)) else {
                fatalError("stub path is missing")
            }
            return fixture(filePath: stubPath, headers: ["Content-Type":"application/json"])
        }
        
        var result: Result<TestModel, APIClientError>?
        client?.object(TestResource()) { (resultData: Result<TestModel, APIClientError>) in
            result = resultData
        }
        
        expect(result?.value?.foo).toEventually(equal("hello, world!"))
    }
    
    func testReturnsNetworkErrorIfThereIsNoConnection() {
        stub(condition: isHost("test.com")) { _ in
            return OHHTTPStubsResponse(error: NSError.networkError())
        }
        
        var result: Result<TestModel, APIClientError>?
        client?.object(TestResource()) { (resultData: Result<TestModel, APIClientError>) in
            result = resultData
        }
        
        let error = APIClientError.httpClientError(error: NSError.networkError())
        expect(result?.error).toEventually(equal(error))
    }
    
    func testReturnsStatus200IfOperationGetsCode200() {
        stub(condition: isHost("test.com")) { _ in
            return OHHTTPStubsResponse(data: Data(), statusCode: 200, headers: nil)
        }
        
        var result: Result<HTTPStatusCode, APIClientError>?
        client?.status(TestResource()) { (resultData: Result<HTTPStatusCode, APIClientError>) in
            result = resultData
        }
        
        let status = 200
        expect(result?.value).toEventually(equal(status))
    }
    
    func testReturnsNetworkErrorIfStatusHasNoConnection() {
        stub(condition: isHost("test.com")) { _ in
            return OHHTTPStubsResponse(error: NSError.networkError())
        }
        
        var result: Result<HTTPStatusCode, APIClientError>?
        client?.status(TestResource()) { (resultData: Result<HTTPStatusCode, APIClientError>) in
            result = resultData
        }
        
        let error = APIClientError.httpClientError(error: NSError.networkError())
        expect(result?.error).toEventually(equal(error))
    }
}
