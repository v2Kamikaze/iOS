//
//  ViewController.swift
//  CatFacts
//
//  Created by Silvia Helena on 04/02/23.
//

import UIKit

class MainViewController: UIViewController {
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Just click to get a random cat fact"
        label.numberOfLines = 3
        label.textAlignment = .center
        label.font = UIFont(name: "Verdana Bold", size: 35)
        return label
    }()
    
    lazy var resLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "teste"
        label.numberOfLines = 3
        label.textAlignment = .center
        label.font = UIFont(name: "Verdana Bold", size: 35)
        return label
    }()
    
    lazy var button: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "buttonPink")
        button.setTitle("New fact", for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "backgroundPink")
        self.view.addSubview(label)
        self.view.addSubview(button)
        self.view.addSubview(resLabel)
        configConstraints()
    }
    
    @objc func onClick() {
        self.resLabel.text = "clicou"
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            self.label.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50),
            self.label.bottomAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.centerYAnchor),
            self.label.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.label.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            self.button.topAnchor.constraint(equalTo: self.label.bottomAnchor, constant: 30),
            self.button.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.button.widthAnchor.constraint(equalToConstant: 200),
            
            self.resLabel.topAnchor.constraint(equalTo: self.button.bottomAnchor, constant: 80),
            self.resLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            
        ])
        
    }
    
}

