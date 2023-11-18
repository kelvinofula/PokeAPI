//
//  PokemonListViewModel.swift
//  PokeAPI
//
//  Created by Kelvin Ofula on 11/18/23.
//

import Foundation
import Combine

class PokemonListViewModel: ObservableObject {
    @Published var pokemonList: [Pokemon] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    func fetchPokemonList() {
        NetworkManager.shared.fetchPokemonList()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { response in
                debugPrint(response)
            },
                  receiveValue: { [weak self] response in
                self?.pokemonList = response.results
                debugPrint(response.results)
            })
            .store(in: &cancellables)
    }
}
