//
//  Superheroes.swift
//  SuperHeroes
//
//  Created by Oscar on 16/5/18.
//  Copyright © 2018 Oscar García. All rights reserved.
//

import Foundation

struct Superheroes {
    
    enum CodingKeys: String, CodingKey {
        case superheroes
    }
    
    var superheroes: [Superheroe]
}

extension Superheroes: Decodable {
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        superheroes = try values.decode([Superheroe].self, forKey: .superheroes)
    }
}

extension Superheroes: Encodable {
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(superheroes, forKey: .superheroes)
    }
}
