//
//  PokemonCardViewCell.swift
//  PokedexDemo
//
//  Created by Ivan Miller Medeiros Cardoso on 22/08/23.
//

import Foundation
import UIKit

class PokemonCardViewCell: UICollectionViewCell {
    
    static let idenfier: String = "PokemonCardViewCell"
    
    private let backgroundCard: UIView = {
        let bg = UIView()
        bg.translatesAutoresizingMaskIntoConstraints = false
        bg.layer.cornerRadius = 12
        bg.backgroundColor = .systemCyan
        return bg
    }()
    
    private lazy var sprite: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    private let nameLabel: UILabel = {
        $0.font = UIFont(name: "Helvetica Bold", size: 20)
        $0.textColor = .white
        $0.numberOfLines = 0
        $0.textAlignment = .left
        $0.sizeToFit()
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private let numberLabel: UILabel = {
        $0.font = UIFont(name: "Helvetica Bold", size: 16)
        $0.textColor = .systemGray6
        $0.numberOfLines = 0
        $0.textAlignment = .left
        $0.sizeToFit()
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let stackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.alignment = .fill
        return $0
    }(UIStackView())
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(backgroundCard)
        contentView.addSubview(sprite)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(numberLabel)
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            backgroundCard.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            backgroundCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            backgroundCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            backgroundCard.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            sprite.topAnchor.constraint(equalTo: backgroundCard.topAnchor, constant: 8),
            sprite.trailingAnchor.constraint(equalTo: backgroundCard.trailingAnchor, constant: -8),
            sprite.bottomAnchor.constraint(equalTo: backgroundCard.bottomAnchor, constant: -8),
            sprite.leadingAnchor.constraint(equalTo: stackView.trailingAnchor),
            sprite.widthAnchor.constraint(equalTo: backgroundCard.widthAnchor, multiplier: 0.5)
        ])
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: backgroundCard.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: sprite.leadingAnchor, constant: 8),
            stackView.centerYAnchor.constraint(equalTo: sprite.centerYAnchor)
        ])

    }
    
    required init?(coder: NSCoder) {
        return  nil
    }
    
    func setupCard(pokemon: PokemonListModel) {
        nameLabel.text = pokemon.name.uppercased()
        numberLabel.text = "#\(pokemon.getIndex())"
        sprite.load(url: pokemon.getSpriteUrl())
    }
}
