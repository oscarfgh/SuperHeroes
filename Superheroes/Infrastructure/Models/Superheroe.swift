//
//  Superheroe.swift
//  SuperHeroes
//
//  Created by Oscar on 16/5/18.
//  Copyright © 2018 Oscar García. All rights reserved.
//

import Foundation

struct Superheroe {
    
    enum CodingKeys: String, CodingKey {
        case name
        case photo
        case realName
        case height
        case power
        case abilities
        case groups
    }
    
    var name: String
    var photo: URL
    var realName: String
    var height: String
    var power: String
    var abilities: String
    var groups: String
}

extension Superheroe: Decodable {
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try values.decode(String.self, forKey: .name)
        photo = try values.decode(URL.self, forKey: .photo)
        realName = try values.decode(String.self, forKey: .realName)
        height = try values.decode(String.self, forKey: .height)
        power = try values.decode(String.self, forKey: .power)
        abilities = try values.decode(String.self, forKey: .abilities)
        groups = try values.decode(String.self, forKey: .groups)
    }
}

extension Superheroe: Encodable {
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(photo, forKey: .photo)
        try container.encode(realName, forKey: .realName)
        try container.encode(height, forKey: .height)
        try container.encode(power, forKey: .power)
        try container.encode(abilities, forKey: .abilities)
        try container.encode(groups, forKey: .groups)
    }
}
