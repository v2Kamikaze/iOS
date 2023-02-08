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
        self.setTitleColor(.black, for: .normal)
        self.titleLabel?.font = UIFont(name: "Verdana", size: 15)
        self.layer.cornerRadius = 5
        self.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.borderWidth = 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
