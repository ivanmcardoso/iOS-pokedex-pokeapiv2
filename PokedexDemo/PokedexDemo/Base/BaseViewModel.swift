//
//  BaseViewModel.swift
//  PokedexDemo
//
//  Created by Ivan Miller Medeiros Cardoso on 23/08/23.
//

import Foundation

class BaseViewModel {
    enum State<T> {
        case Error(Error?)
        case Loading
        case Success(T)
    }

}
