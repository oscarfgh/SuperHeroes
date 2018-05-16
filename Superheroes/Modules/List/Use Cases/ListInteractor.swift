//
//  ListInteractor.swift
//  Superheroes
//
//  Created by Oscar on 16/5/18.
//  Copyright © 2018 Oscar García. All rights reserved.
//

import Foundation

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
}
