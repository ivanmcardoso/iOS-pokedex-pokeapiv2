//
//  UIImageViewExtension.swift
//  PokedexDemo
//
//  Created by Ivan Miller Medeiros Cardoso on 22/08/23.
//

import Foundation
import UIKit

extension UIImageView {
    func load(url: URL?) {
        guard let url = url else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
