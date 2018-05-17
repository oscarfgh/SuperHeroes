//
//  SuperheroeModelTests.swift
//  SuperheroesTests
//
//  Created by Oscar on 17/5/18.
//  Copyright © 2018 Oscar García. All rights reserved.
//

import Foundation
import Nimble
import XCTest

@testable import Superheroes

class SuperheroeModelTests: AcceptanceTestCase {
    
    func testJSONDecoding() {
        guard
            let object: Superheroes = createCodeableFromFile(named: "response"),
            let model: Superheroe = object.superheroes.first else {
                XCTFail("Parse error")
                return
        }
        
        let name = "Spiderman"
        let photo =  "https://i.annihil.us/u/prod/marvel/i/mg/9/30/538cd33e15ab7/standard_xlarge.jpg"
        let realName =  "Peter Benjamin Parker"
        let height =  "1.77m"
        let power = "Peter can cling to most surfaces, has superhuman strength (able to lift 10 tons optimally) and is roughly 15 times more agile than a regular human."
        let abilities = "Peter is an accomplished scientist, inventor and photographer."
        let groups = "Avengers, formerly the Secret Defenders, \"New Fantastic Four\", the Outlaws"
        
        
        expect(name).to(equal(model.name))
        expect(photo).to(equal(model.photo.absoluteString))
        expect(realName).to(equal(model.realName))
        expect(height).to(equal(model.height))
        expect(power).to(equal(model.power))
        expect(abilities).to(equal(model.abilities))
        expect(groups).to(equal(model.groups))
    }
}
