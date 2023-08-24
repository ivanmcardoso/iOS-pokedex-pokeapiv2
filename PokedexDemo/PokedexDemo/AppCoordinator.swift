//
//  AppCordinator.swift
//  PokedexDemo
//
//  Created by Ivan Miller Medeiros Cardoso on 21/08/23.
//

import Foundation
import UIKit

final class AppCoordinator: BaseCoordinator {
    
    let window: UIWindow?
       
    lazy var rootViewController: UINavigationController = {
       return UINavigationController(rootViewController: UIViewController())
    }()
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        guard let window = window else {
            return
        }

        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        
        let homeCoordinator = HomeCoordinator(rootViewController: rootViewController)
        homeCoordinator.start()
    }
}
