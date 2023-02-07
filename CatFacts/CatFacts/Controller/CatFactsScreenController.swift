//
//  CatFactScreenController.swift
//  CatFacts
//
//

import UIKit

class CatFactsScreenController: UIViewController {
    
    let manager = CatFactsManager.shared
    
    var facts: CatFactsModel = []
    
    let paddingLeft = CGFloat(10)
    let paddingRight = CGFloat(-10)
        
    lazy var progressIndicator: UIActivityIndicatorView = ProgressIndicator()
    
    let label: UILabel = LargeTitleLabel(text: "Just click to get a random cat fact")
    
    let backgroundImage: UIImageView = AppBackgroundImage()
    
    lazy var button: UIButton = {
        var button = PinkRoundedButton(text: "Get Facts")
        button.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        return button
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    
    lazy var resLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.numberOfLines = .max
        label.textAlignment = .center
        label.font = UIFont(name: "Verdana Bold", size: 20)
        return label
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    @objc func onClick() {
        self.progressIndicator.startAnimating()
        manager.getFacts { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                print("Ocorreu um erro:  \(error)")
                return
            case .success(let facts):
                self.facts = facts
                
                DispatchQueue.main.async {
                    self.progressIndicator.stopAnimating()
                    self.resLabel.text = facts.map { $0.text }.joined(separator: "\n")
                }
            }
        }
    }
    
}

extension CatFactsScreenController : ViewCodeBuild {
    func buildViewHierarchy() {
        self.view.backgroundColor = UIColor(named: "backgroundPink")
        self.view.addSubview(backgroundImage)
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(label)
        self.scrollView.addSubview(button)
        self.scrollView.addSubview(resLabel)
        self.scrollView.addSubview(progressIndicator)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // MARK: - Background Constraints
            self.backgroundImage.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.backgroundImage.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.backgroundImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            // MARK: - ScrollView BackgroundImage
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            // MARK: - Configuring Label inside ScrollView
            self.label.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 20),
            self.label.bottomAnchor.constraint(lessThanOrEqualTo: self.scrollView.centerYAnchor),
            self.label.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: paddingLeft),
            self.label.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: paddingRight),
            
            // MARK: - Configuring Button inside ScrollView
            self.button.topAnchor.constraint(equalTo: self.label.bottomAnchor, constant: 30),
            self.button.centerXAnchor.constraint(equalTo: self.label.centerXAnchor),
            self.button.widthAnchor.constraint(equalToConstant: 200),
            
            // MARK: - Configuring ResLabel inside ScrollView
            self.resLabel.topAnchor.constraint(equalTo: self.button.bottomAnchor, constant: 80),
            self.resLabel.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.resLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: paddingLeft),
            self.resLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: paddingRight),
            
            // MARK: - Configuring ProgressIndicator inside ScrollView
            self.progressIndicator.topAnchor.constraint(equalTo: self.button.bottomAnchor, constant: 80),
            self.progressIndicator.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.progressIndicator.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: paddingLeft),
            self.progressIndicator.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: paddingRight),
            
        ])
    }
    
    func setupAdditionalConfiguration() {}
    
    
}
