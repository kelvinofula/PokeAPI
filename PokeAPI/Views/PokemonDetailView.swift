//
//  PokemonDetailView.swift
//  PokeAPI
//
//  Created by Kelvin Ofula on 11/18/23.
//

import SwiftUI
import Kingfisher

struct PokemonDetailView: View {
    
    @ObservedObject var viewModel: PokemonDetailViewModel
    var pokemonId: Int
    
    init(viewModel: PokemonDetailViewModel, pokemonId: Int) {
        self.viewModel = viewModel
        self.pokemonId = pokemonId
    }
    
    var body: some View {
        ScrollView {
            if let pokemon = viewModel.pokemonDetail {
                VStack(alignment: .center, spacing: 20) {
                    KFImage(URL(string: pokemon.sprites.frontDefault))
                        .resizable()
                        .frame(width: 150, height: 150)
                        .aspectRatio(contentMode: .fit)
                    Text(pokemon.name.capitalized)
                        .font(.title)
                    Text("ID: \(pokemon.id)")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("Type: \(pokemon.types.map { $0.type.name.capitalized }.joined(separator: ", "))")
                        .font(.subheadline)
                    Text("Abilities: \(pokemon.abilities.map { $0.ability.name.capitalized }.joined(separator: ", "))")
                        .font(.subheadline)
                    Text("Moves: \(pokemon.moves.map { $0.move.name.capitalized }.joined(separator: ", "))")
                        .font(.subheadline)
                }
                .padding()
                .onAppear {
                    //viewModel.reset()
                    viewModel.fetchPokemonDetail(for: pokemonId)
                }
            } else {
                Text("Loading...")
                    .onAppear {
                        viewModel.fetchPokemonDetail(for: pokemonId)
                    }
            }
        }
        .navigationTitle("Pokemon Detail")
    }
}
