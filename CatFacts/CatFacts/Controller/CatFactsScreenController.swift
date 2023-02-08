//
//  CatFactScreenController.swift
//  CatFacts
//
//

import UIKit

class CatFactsScreenController: UIViewController {
    
    let manager = CatFactsManager.shared
    
    let defaults = UserDefaults.standard
    
    var facts: CatFactsModel = []
    
    let paddingLeft = CGFloat(10)
    let paddingRight = CGFloat(-10)
        
    lazy var progressIndicator: UIActivityIndicatorView = ProgressIndicator()
    
    let label: UILabel = LargeTitleLabel(text: "Daily random cat facts")
    
    let backgroundImage: UIImageView = AppBackgroundImage()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    
    lazy var factsList = {
        AppTableView(from: facts)
    }()
    
    lazy var column: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    func loadFacts() {
        self.progressIndicator.startAnimating()
        manager.getFacts { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                print("Ocorreu um erro:  \(error)")
                return
            case .success(let facts):
                DispatchQueue.main.async {
                    self.progressIndicator.stopAnimating()
                    self.facts = facts
                    self.factsList.data = facts
                    self.factsList.reloadData()
                }
            }
        }
    }
    
}

extension CatFactsScreenController : ViewCodeBuild {
    func buildViewHierarchy() {
        self.view.addSubview(backgroundImage)
        self.column.addArrangedSubview(label)
        self.column.addArrangedSubview(factsList)
        self.scrollView.addSubview(column)
        self.view.addSubview(scrollView)
        self.view.addSubview(progressIndicator)
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
            
            // MARK: - Column
            self.column.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.column.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.column.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            self.column.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            
            // MARK: - Configuring ProgressIndicator inside ScrollView
            self.progressIndicator.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
            self.progressIndicator.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.view.backgroundColor = UIColor(named: "backgroundPink")
        self.loadFacts()
    }
}
