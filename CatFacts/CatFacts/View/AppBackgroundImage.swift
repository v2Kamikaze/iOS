//
//  AppBackgroundImage.swift
//  CatFacts
//
//

import UIKit

class AppBackgroundImage: UIImageView {
    
    init() {
        super.init(frame: .zero)
        self.image = UIImage(named: "background")
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = .scaleAspectFill
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

