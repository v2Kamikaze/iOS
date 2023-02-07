//
//  CatFactsList.swift
//  CatFacts
//
//

import UIKit

class CatFactsListScreenController: UIViewController {
    
    var data: CatFactsModel = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    lazy var tableView: UITableView = {
        return AppTableView(from: data)
    }()
    
    let label = LargeTitleLabel(text: "Last Facts List")
    
    let backgroundImage: UIImageView = AppBackgroundImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
}

extension CatFactsListScreenController: ViewCodeBuild {
    func buildViewHierarchy() {
        self.view.addSubview(backgroundImage)
        self.view.addSubview(label)
        self.view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // MARK: - Background Image
            self.backgroundImage.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.backgroundImage.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.backgroundImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.backgroundImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            // MARK: - Label
            self.label.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.label.bottomAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.centerYAnchor),
            self.label.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            self.label.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            // MARK: - TableView
            self.tableView.topAnchor.constraint(equalTo: self.label.bottomAnchor, constant: 30),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
    func setupAdditionalConfiguration() {}
    
    
}
