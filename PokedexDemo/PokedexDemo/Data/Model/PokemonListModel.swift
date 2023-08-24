//
//  PokemonData.swift
//  PokedexDemo
//
//  Created by Ivan Miller Medeiros Cardoso on 22/08/23.
//

import Foundation

public struct PokemonListModel : Codable {
    let name: String
    let url: String
    
    func getSpriteUrl() -> URL? {
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(getIndex()).png")
    }
    
    func getIndex() -> String {
        return String(url.replacingOccurrences(of: "https://pokeapi.co/api/v2/pokemon/", with: "").dropLast(1))
    }
}
