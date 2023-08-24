//
//  PokemonDetailsViewModel.swift
//  PokedexDemo
//
//  Created by Ivan Miller Medeiros Cardoso on 23/08/23.
//

import Foundation
import RxSwift
import RxCocoa

class PokemonDetailViewModel: BaseViewModel {
    
    private let service: PokemonService
    private let pokemon: PokemonListModel
    
    let state = PublishSubject<State<PokemonModel?>>()
    
    init(service:PokemonService, pokemon: PokemonListModel){
        self.service = service
        self.pokemon = pokemon
    }
    
    func fetchPokemon() {
        state.onNext(.Loading)
        service.fetchPokemonById(pokemonId: pokemon.getIndex()) { [state] response in
            switch response {
            case .success(let pokemonData):
                state.onNext(.Success(pokemonData))
            case .failure(let errorResponse):
                state.onNext(.Error(errorResponse))
            }
        }
    }
    
}
