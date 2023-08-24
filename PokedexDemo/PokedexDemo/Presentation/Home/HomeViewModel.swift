//
//  HomeViewModel.swift
//  PokedexDemo
//
//  Created by Ivan Miller Medeiros Cardoso on 21/08/23.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel: BaseViewModel {
    
    private let service: PokemonService
    
    init(service: PokemonService){
        self.service = service
    }
    
    let navigation = PublishSubject<Navigation>()
    let state = PublishSubject<State<[PokemonListModel]?>>()
    var pokemons: [PokemonListModel]? = nil
    
    func goToDetails(pokemon: PokemonListModel) {
        navigation.onNext(.select(pokemon: pokemon))
    }
    
    func fetchEvents() {
        state.onNext(.Loading)
        service.fetchPokemon { [state] response in
            switch response {
            case .success(let pokemonsArray):
                state.onNext(.Success(pokemonsArray.results))
            case .failure(let errorResponse):
                state.onNext(.Error(errorResponse))
            }
        }
    }
}

extension HomeViewModel {
    enum Navigation {
        case goBack
        case select(pokemon: PokemonListModel)
    }
}
