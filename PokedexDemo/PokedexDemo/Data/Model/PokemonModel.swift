//
//  PokemonModel.swift
//  PokedexDemo
//
//  Created by Ivan Miller Medeiros Cardoso on 23/08/23.
//

import Foundation

struct PokemonModel: Codable {
    
    let baseExperience: Int
    let height: Int
    let id: Int
    let name: String
    let sprites: Sprites
    let stats: [Stat]
    let types: [TypeElement]
    let weight: Int

    enum CodingKeys: String, CodingKey {
        case baseExperience = "base_experience"
        case height, id, name, sprites, stats, types, weight
    }
}

class Sprites: Codable {
    let backDefault: String?
    let backFemale: String?
    let backShiny: String?
    let backShinyFemale: String?
    let frontDefault: String?
    let frontFemale: String?
    let frontShiny: String?
    let frontShinyFemale: String?
    
    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backFemale = "back_female"
        case backShiny = "back_shiny"
        case backShinyFemale = "back_shiny_female"
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
    }

    init(backDefault: String?, backFemale: String?, backShiny: String?, backShinyFemale: String?, frontDefault: String?, frontFemale: String?, frontShiny: String?, frontShinyFemale: String?) {
        self.backDefault = backDefault
        self.backFemale = backFemale
        self.backShiny = backShiny
        self.backShinyFemale = backShinyFemale
        self.frontDefault = frontDefault
        self.frontFemale = frontFemale
        self.frontShiny = frontShiny
        self.frontShinyFemale = frontShinyFemale
    }
}

internal extension String {
    func toURL() -> URL? {
        return URL(string: self)
    }
}

struct Stat: Codable {
    let baseStat, effort: Int

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort
    }
}

struct TypeElement: Codable {
    let slot: Int
    let type: PokemonType
}

struct PokemonType: Codable {
    let name: String
    let url: String
}
