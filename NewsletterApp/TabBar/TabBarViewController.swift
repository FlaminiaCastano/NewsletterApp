//
//  TabBarViewController.swift
//  NewsletterApp
//
//  Created by Flaminia Castaño on 27/12/2023.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        
        self.tabBar.tintColor = .black
        self.tabBar.barTintColor = .white
        
        let newsController = UINavigationController(rootViewController: NewsTableViewController())
        newsController.tabBarItem = UITabBarItem(title: "Noticias", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
           
        let usersController = UINavigationController(rootViewController: UsersTableViewController())
        usersController.tabBarItem = UITabBarItem(title: "Usuarios", image: UIImage(systemName: "person.3"), selectedImage: UIImage(systemName: "person.3.fill"))
        
        self.viewControllers = [newsController, usersController]
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let title = item.title else {
            return
        }
        self.title = title
    }
}
