//
//  PokemonListResquest.swift
//  PokedexDemo
//
//  Created by Ivan Miller Medeiros Cardoso on 22/08/23.
//

import Foundation

struct PokemonListRequest: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonListModel]
}
