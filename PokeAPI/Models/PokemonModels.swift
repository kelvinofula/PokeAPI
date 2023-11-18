//
//  PokemonModels.swift
//  PokeAPI
//
//  Created by Kelvin Ofula on 11/18/23.
//

import Foundation

struct PokemonListResponse: Codable {
    let results: [Pokemon]
}

struct Pokemon: Codable, Identifiable {
    let id: Int
    let name: String
    let url: String
    
    private enum CodingKeys: String, CodingKey {
        case name, url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        url = try container.decode(String.self, forKey: .url)
        
        // Extracting id from the url
        if let idString = url.components(separatedBy: "/").dropLast().last, let pokemonId = Int(idString) {
            id = pokemonId
        } else {
            // Set a default value or handle the absence of id as needed
            id = 0
        }
    }
}

struct PokemonDetail: Codable {
    let id: Int
    let name: String
    let sprites: PokemonSprites
    let types: [PokemonType]
    let abilities: [PokemonAbility]
    let moves: [PokemonMove]
}

struct PokemonSprites: Codable {
    let frontDefault: String
    
    private enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct PokemonType: Codable {
    let type: Type
}

struct Type: Codable {
    let name: String
}

struct PokemonAbility: Codable {
    let ability: Ability
}

struct Ability: Codable {
    let name: String
}

struct PokemonMove: Codable {
    let move: Move
}

struct Move: Codable {
    let name: String
}
