//
//  PokemonDetailsViewController.swift
//  PokedexDemo
//
//  Created by Ivan Miller Medeiros Cardoso on 23/08/23.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class PokemonDetailsViewController: BaseViewController {
    
    private let viewModel: PokemonDetailViewModel
    
    init(viewModel: PokemonDetailViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    private let scrollView: UIScrollView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.showsVerticalScrollIndicator = false
        return $0
    }(UIScrollView())
    
    private let stackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 10
        $0.distribution = .fill
        return $0
    }(UIStackView())

    private lazy var sprite: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    private let nameLabel: UILabel = {
        $0.font = UIFont(name: "Helvetica Bold", size: 24)
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.sizeToFit()
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let numberLabel: UILabel = {
        $0.font = UIFont(name: "Helvetica Bold", size: 24)
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.sizeToFit()
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let heightLabel: UILabel = {
        $0.font = UIFont(name: "Helvetica Bold", size: 24)
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.sizeToFit()
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let weightLabel: UILabel = {
        $0.font = UIFont(name: "Helvetica Bold", size: 24)
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.sizeToFit()
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private let typeLabel: UILabel = {
        $0.font = UIFont(name: "Helvetica Bold", size: 24)
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.sizeToFit()
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindRx()
        viewModel.fetchPokemon()
    }
    
    private func setupUI() {
        
        stackView.addArrangedSubview(sprite)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(numberLabel)
        stackView.addArrangedSubview(heightLabel)
        stackView.addArrangedSubview(weightLabel)
        stackView.addArrangedSubview(typeLabel)
        scrollView.addSubview(stackView)
        view.addSubview(scrollView)
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor )
        ])
        
        NSLayoutConstraint.activate([
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24)
        ])
    }
}

extension PokemonDetailsViewController {
    
    func bindRx() {
        viewModel.state.observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { state in
                switch state {
                case .Success(let pokemonData):
                    guard let pokemon = pokemonData else {return}
                    self.bindData(pokemonData: pokemon)
                case .Error(let error):
                    guard let error = error else {return}
                    print(error)
                default:
                    print("erro")
                }
            }).disposed(by: disposeBag)
    }
}

extension PokemonDetailsViewController {
    func bindData(pokemonData: PokemonModel) {
        nameLabel.text = pokemonData.name.uppercased()
        numberLabel.text = "#\(pokemonData.id)"
        sprite.load(url: pokemonData.sprites.frontDefault?.toURL())
        heightLabel.text = "Altura: \(Double(pokemonData.height)/10.0)m"
        weightLabel.text = "Peso: \(Double(pokemonData.weight)/10.0)kg"
        var nameString = ""
        pokemonData.types.forEach{ type in
            nameString += "\(type.type.name) "
        }
        typeLabel.text = "Tipos: \(String(nameString.dropLast(1)))"
    }
}
