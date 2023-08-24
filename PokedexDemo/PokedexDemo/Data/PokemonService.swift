//
//  PokemonService.swift
//  PokedexDemo
//
//  Created by Ivan Miller Medeiros Cardoso on 22/08/23.
//

import Foundation

class PokemonService {
    func fetchPokemon(completion: @escaping (Result<PokemonListRequest, Error>) -> Void) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=10&offset=0") else {
            return
        }
        
        
        let task = URLSession.shared.dataTask(with: url) { data, response, sessionError in
            if let error  = sessionError {
                completion(.failure(error))
            }
            let decoder = JSONDecoder()
            do{
                let response = try decoder.decode(PokemonListRequest.self, from: data ?? Data())
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func fetchPokemonById(pokemonId: String, completion: @escaping (Result<PokemonModel, Error>) -> Void) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(pokemonId)") else {
            return
        }
        
        
        let task = URLSession.shared.dataTask(with: url) { data, response, sessionError in
            if let error  = sessionError {
                completion(.failure(error))
            }
            let decoder = JSONDecoder()
            do{
                let response = try decoder.decode(PokemonModel.self, from: data ?? Data())
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
}
