//
//  HomeViewController.swift
//  PokedexDemo
//
//  Created by Ivan Miller Medeiros Cardoso on 21/08/23.
//

import Foundation
import UIKit
import RxSwift

class HomeViewController : BaseViewController {
    
    private let viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    private let titleLabel: UILabel = {
        $0.text = "Pokedex"
        $0.font = UIFont(name: "Helvetica Bold", size: 24)
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.textAlignment = .left
        $0.sizeToFit()
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    lazy var pokemonListCollection: UICollectionView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .none
        $0.register(PokemonCardViewCell.self, forCellWithReuseIdentifier: PokemonCardViewCell.idenfier)
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        $0.setCollectionViewLayout(layout, animated: false)
        $0.delegate = self
        $0.dataSource = self
        $0.showsVerticalScrollIndicator = false
        return $0
    }(UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init()))
    
    let loadSpinner: UIActivityIndicatorView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.hidesWhenStopped = true
        $0.style = .large
        $0.color = .systemCyan
        return $0
    }(UIActivityIndicatorView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData()
        bindRx()
    }
    
    private func fetchData(){
        viewModel.fetchEvents()
    }
    
    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(pokemonListCollection)
        view.addSubview(loadSpinner)
        view.backgroundColor = .white

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
                
        NSLayoutConstraint.activate([
            pokemonListCollection.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            pokemonListCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            pokemonListCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            pokemonListCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            loadSpinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadSpinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let pokemon = viewModel.pokemons?[indexPath.row] else {
                return
        }
        viewModel.goToDetails(pokemon: pokemon)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.pokemons?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCardViewCell.idenfier, for: indexPath) as? PokemonCardViewCell else {
            return UICollectionViewCell()
        }
        guard let pokemon = viewModel.pokemons?[indexPath.row] else {
            return cell
        }
        cell.setupCard(pokemon: pokemon)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.width, height: collectionView.frame.width/2)
    }
    
}

private extension HomeViewController {
    func bindRx() {
        loadSpinner.startAnimating()
        viewModel.state.observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: {[pokemonListCollection, loadSpinner, viewModel] state in
                switch state {
                case .Success(let pokemons):
                        loadSpinner.stopAnimating()
                        pokemonListCollection.isHidden = false
                        viewModel.pokemons = pokemons
                        pokemonListCollection.reloadData()
                case .Loading:
                    loadSpinner.startAnimating()
                    pokemonListCollection.isHidden = true
                    
                default:
                    loadSpinner.stopAnimating()

                }
            }).disposed(by: disposeBag)
    }
}
