//
//  PokemonDetailViewModel.swift
//  PokeAPI
//
//  Created by Kelvin Ofula on 11/18/23.
//

import Foundation
import Combine

class PokemonDetailViewModel: ObservableObject {
    @Published var pokemonDetail: PokemonDetail?
    
    private var cancellables: Set<AnyCancellable> = []
    
    func fetchPokemonDetail(for id: Int) {
        if let cachedDetail = CacheManager.shared.loadPokemonDetail(for: id) {
            self.pokemonDetail = cachedDetail
        }
        
        NetworkManager.shared.fetchPokemonDetail(for: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { obj in
                debugPrint("THE RESPONSE -> \(obj)")
            },
                  receiveValue: { [weak self] response in
                self?.pokemonDetail = response
                CacheManager.shared.savePokemonDetail(response, for: id)
            })
            .store(in: &cancellables)
    }
    
    func reset() {
        self.pokemonDetail = nil
    }
}
