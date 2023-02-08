//
//  LargeTitleLabel.swift
//  CatFacts
//
//

import UIKit

class LargeTitleLabel: UILabel {
    
    init(text: String) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.text = text
        self.numberOfLines = 4
        self.textAlignment = .center
        self.font = UIFont(name: "Verdana Bold", size: 35)
        self.adjustsFontSizeToFitWidth = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
