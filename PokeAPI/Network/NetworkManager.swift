//
//  NetworkManager.swift
//  PokeAPI
//
//  Created by Kelvin Ofula on 11/18/23.
//

import Foundation
import Combine

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    func fetchPokemonList() -> AnyPublisher<PokemonListResponse, Error> {
        let url = baseURL
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: PokemonListResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func fetchPokemonDetail(for id: Int) -> AnyPublisher<PokemonDetail, Error> {
        let url = baseURL.appendingPathComponent("\(id)")
        debugPrint("Pokemon url -> \(url)")
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: PokemonDetail.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
}
