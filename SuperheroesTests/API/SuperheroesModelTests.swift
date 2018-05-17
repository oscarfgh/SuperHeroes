//
//  SuperheroesModelTests.swift
//  SuperheroesTests
//
//  Created by Oscar on 17/5/18.
//  Copyright © 2018 Oscar García. All rights reserved.
//

import XCTest
import Nimble

@testable import Superheroes

class SuperheroesModelTests: AcceptanceTestCase {

    func testJSONDecoding() {
        guard let object: Superheroes = createCodeableFromFile(named: "response") else {
            XCTFail("Parse error")
            return
        }
        
        expect(6).to(equal(object.superheroes.count))
    }

    func testInvalidJSONDecoding() {
        guard let _: Superheroes = createCodeableFromFile(named: "test") else {
            XCTAssert(true)
            return
        }
        
        XCTFail("Parse Error")
    }
}
