//
//  SuperheroesRepository.swift
//  Superheroes
//
//  Created by Oscar on 16/5/18.
//  Copyright © 2018 Oscar García. All rights reserved.
//

import Foundation
import Result

protocol SuperheroesStoring {
    
    func superheroes(completion: @escaping (Result<Superheroes, APIClientError>) -> Void)
}

final class SuperHeroesRepository: SuperheroesStoring {
    
    private lazy var superheoresAPI: APIClient = {
        return APIClient.superheroesAPIClient()
    }()
    
    func superheroes(completion: @escaping (Result<Superheroes, APIClientError>) -> Void) {
        superheoresAPI.superheroes { (result: Result<Superheroes, APIClientError>) in
            completion(result)
        }
    }
}
