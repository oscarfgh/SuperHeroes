//
//  ListInteractor.swift
//  Superheroes
//
//  Created by Oscar on 16/5/18.
//  Copyright © 2018 Oscar García. All rights reserved.
//

import Foundation
import Result

struct ListInteractorDependencies: HasSuperheroesStoring {

    var superheroesRepository: SuperheroesStoring

    static func make() -> ListInteractorDependencies {
        let container = ListInteractorDependencies(
            superheroesRepository: SuperHeroesRepository()
        )

        return container
    }
}

class ListInteractor {

    typealias Dependencies = HasSuperheroesStoring

    let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    deinit {
        print("Bye ListInteractor!")
    }
    
    func superheroes(completionQueue: DispatchQueue = DispatchQueue.main,
                     completion: @escaping (Result<Superheroes, APIClientError>) -> Void) {
        dependencies.superheroesRepository.superheroes { (result: Result<Superheroes, APIClientError>) in
            completionQueue.async {
                switch result {
                case .failure(let error):
                    completion(Result(error: error))
                case .success(let superheroes):
                    completion(Result(value: superheroes))
                }
            }
        }
    }
}
