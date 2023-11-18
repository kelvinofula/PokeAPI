//
//  CacheManager.swift
//  PokeAPI
//
//  Created by Kelvin Ofula on 11/18/23.
//

import Foundation

class CacheManager {
    static let shared = CacheManager()
    private init() {}
    
    func savePokemonDetail(_ detail: PokemonDetail, for id: Int) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(detail) {
            UserDefaults.standard.set(encoded, forKey: "pokemonDetail_\(id)")
        }
    }
    
    func loadPokemonDetail(for id: Int) -> PokemonDetail? {
        if let savedPokemonDetail = UserDefaults.standard.object(forKey: "pokemonDetail_\(id)") as? Data {
            let decoder = JSONDecoder()
            if let loadedPokemonDetail = try? decoder.decode(PokemonDetail.self, from: savedPokemonDetail) {
                return loadedPokemonDetail
            }
        }
        return nil
    }
}
