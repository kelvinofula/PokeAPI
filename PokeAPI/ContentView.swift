//
//  ContentView.swift
//  PokeAPI
//
//  Created by Kelvin Ofula on 11/18/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: PokemonListViewModel
    @StateObject private var detailViewModel = PokemonDetailViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            List {
                Text("Use the advanced search to find Pokemon by type, weakness, ability and more!")
                    .font(.caption)
                    .foregroundColor(.gray)
                SearchBar(text: $searchText)
                ForEach(filteredPokemonList, id: \.id) { pokemon in
                    NavigationLink(destination: PokemonDetailView(viewModel: detailViewModel, pokemonId: pokemon.id)) {
                        PokemonListRow(pokemon: pokemon)
                    }
                }
            }
            .onAppear {
                viewModel.fetchPokemonList()
            }
            .navigationTitle("Pokedex")
        }
    }
    
    private var filteredPokemonList: [Pokemon] {
        if searchText.isEmpty {
            return viewModel.pokemonList
        } else {
            return viewModel.pokemonList.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
}
