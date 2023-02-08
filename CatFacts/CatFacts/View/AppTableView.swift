//
//  AppTableView.swift
//  CatFacts
//
//

import UIKit

class AppTableView: UITableView {
    
    var data: CatFactsModel = []

    init(from data: CatFactsModel) {
        super.init(frame: .zero, style: .plain)
        self.data = data
        self.delegate = self
        self.dataSource = self
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        self.allowsSelection = false
        self.separatorStyle = .none
        self.register(UITableViewCell.self, forCellReuseIdentifier: "fact_cell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AppTableView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fact_cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = data[indexPath.row].text
        cell.textLabel?.numberOfLines = 5
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 5
        cell.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        cell.layer.borderWidth = 2
        return cell
    }
}

