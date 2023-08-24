//
//  PokemonDetailsCoordinator.swift
//  PokedexDemo
//
//  Created by Ivan Miller Medeiros Cardoso on 23/08/23.
//

import Foundation
import UIKit

class PokemonDetailsCoordinator: BaseCoordinator {
    
    private let rootViewController: UINavigationController
    
    private var service: PokemonService
    private var viewModel: PokemonDetailViewModel
    private var viewController: PokemonDetailsViewController
    
    init(rootViewController: UINavigationController, pokemon: PokemonListModel) {
        self.rootViewController = rootViewController
        self.service = PokemonService()
        self.viewModel = PokemonDetailViewModel(service: service, pokemon: pokemon)
        self.viewController = PokemonDetailsViewController(viewModel: viewModel)
    }
    
    func start() {
        rootViewController.pushViewController(viewController, animated: false)
    }
}
