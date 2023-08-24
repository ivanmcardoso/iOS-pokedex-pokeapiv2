//
//  HomeCoordinator.swift
//  PokedexDemo
//
//  Created by Ivan Miller Medeiros Cardoso on 21/08/23.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

final class HomeCoordinator: BaseCoordinator {
    
    private let rootViewController: UINavigationController

    private var service: PokemonService
    private var viewModel: HomeViewModel
    private var viewController: HomeViewController
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
        self.service = PokemonService()
        self.viewModel = HomeViewModel(service: service)
        self.viewController = HomeViewController(viewModel: viewModel)
    }
    
    func start() {
        handleNavigation()
        rootViewController.pushViewController(viewController, animated: false)
    }
}

extension HomeCoordinator {
    func handleNavigation() {
        viewModel.navigation.observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [rootViewController] navigation in
                switch navigation {
                case .select(let pokemon):
                    PokemonDetailsCoordinator(rootViewController: rootViewController, pokemon: pokemon).start()
                    break
                default:
                    break
                }
            }).disposed(by: viewController.disposeBag)
    }
}
