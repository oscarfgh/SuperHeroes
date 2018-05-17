//
//  MockSuperheroesRepository.swift
//  SuperheroesTests
//
//  Created by Oscar on 17/5/18.
//  Copyright © 2018 Oscar García. All rights reserved.
//

import Foundation
import Result

@testable import Superheroes

class MockSuperheroesRepository: SuperheroesStoring {
    
    var superheroesResult: Result<Superheroes, APIClientError>?
    func superheroes(completion: @escaping (Result<Superheroes, APIClientError>) -> Void) {
        guard let result = superheroesResult else {
            fatalError("Test needs a result")
        }
        completion(result)
    }
}
