//
//  ProgressIndicator.swift
//  CatFacts
//
//

import UIKit

class ProgressIndicator : UIActivityIndicatorView {
    
    init() {
        super.init(frame: .zero)
        self.style = .large
        self.translatesAutoresizingMaskIntoConstraints = false
        self.color = .black
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
