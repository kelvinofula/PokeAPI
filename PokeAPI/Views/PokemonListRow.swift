//
//  PokemonListRow.swift
//  PokeAPI
//
//  Created by Kelvin Ofula on 11/18/23.
//

import SwiftUI
import Kingfisher

struct PokemonListRow: View {
    
    let pokemon: Pokemon
    
    var body: some View {
        HStack {
            KFImage(URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemon.id).png"))
                .resizable()
                .frame(width: 50, height: 50)
                .aspectRatio(contentMode: .fit)
            VStack(alignment: .leading) {
                Text(pokemon.name.capitalized)
                Text("ID: \(pokemon.id)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
}
