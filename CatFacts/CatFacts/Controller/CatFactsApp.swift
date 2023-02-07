//
//  ViewController.swift
//  CatFacts
//

import UIKit


class CatFactsApp: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarControllers()
        setupTabBarStyle()
        
    }
    
    private func setupTabBarStyle() {
        UITabBar.appearance().tintColor = .black
        self.tabBar.backgroundColor = .white
    }
    
    private func setupTabBarControllers() {
        let factsController = UINavigationController(rootViewController: CatFactsScreenController())
        factsController.title = "Cat Facts"
        factsController.tabBarItem.image = UIImage(systemName: "questionmark.circle")
        let catImagesController = UINavigationController(rootViewController: CatImagesScreenController())
        catImagesController.title = "Cat Images"
        catImagesController.tabBarItem.image = UIImage(systemName: "photo")
        let factsListController = UINavigationController(rootViewController: CatFactsListScreenController())
        factsListController.title = "Facts List"
        factsListController.tabBarItem.image = UIImage(systemName: "list.clipboard")
        self.setViewControllers([factsController, catImagesController, factsListController], animated: true)
    }
}

