//
//  FirstHomeViewController.swift
//  SmartCollect
//
//  Created by CristianoDaoHung on 18/12/2021.
//

import UIKit

class TabBar: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVCs()
        tabBar.tintColor = .systemPink
        
    }
    func setupVCs() {
        viewControllers = [
            createNavController(for: HomeViewController(), image: UIImage(named: "bidu")!),
            createNavController(for: HomeViewController(), image: UIImage(named: "shop")!),
            createNavController(for: HomeViewController(), image: UIImage(named: "heart")!),
            createNavController(for: HomeViewController(), image: UIImage(named: "categories")!),
            createNavController(for:HomeViewController(), image: UIImage(named: "shape")!)
        ]
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                         image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.image = image
        return navController
    }
}

