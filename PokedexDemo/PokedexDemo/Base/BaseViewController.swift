//
//  BaseViewController.swift
//  PokedexDemo
//
//  Created by Ivan Miller Medeiros Cardoso on 21/08/23.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class BaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    var moveToNextScreenHandler: (() -> Void)?
    
    lazy var contentView: UIView = {
        $0.backgroundColor = .red
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView(frame: .zero))
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        return nil
    }
}
