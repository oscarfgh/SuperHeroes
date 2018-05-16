//
//  HasDependency.swift
//  Superheroes
//
//  Created by Oscar on 16/5/18.
//  Copyright © 2018 Oscar García. All rights reserved.
//

import Foundation

protocol HasSuperheroesStoring {
    
    var superheroesRepository: SuperheroesStoring { get }
}
