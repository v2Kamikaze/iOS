//
//  PinkRoundedButton.swift
//  CatFacts
//
//

import UIKit

class PinkRoundedButton: UIButton {
    
    init(text: String) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor(named: "buttonPink")
        self.setTitle(text, for: .normal)
        self.layer.cornerRadius = 5
        self.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        self.layer.borderWidth = 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
