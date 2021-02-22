//
//  CustomTabBarViewController.swift
//  Numberator
//
//  Created by Максим Соловьёв on 22.02.2021.
//

import UIKit

class CustomTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
        
        viewControllers = [
                    createTabBarItem(tabBarTitle: "Простые", tabBarImage: "num", viewController: PrimeNumbersViewController()),
                    createTabBarItem(tabBarTitle: "Фибоначчи", tabBarImage: "fib", viewController: FibonacciNumbersViewController())
                ]
    }
    
    override var prefersStatusBarHidden: Bool {
         return true
    }
    
    private func setupTabBar() {
        tabBar.barTintColor = .white
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .systemGray
        tabBar.isTranslucent = false
    }
    
    private func createTabBarItem(tabBarTitle: String, tabBarImage: String, viewController: UIViewController) -> UINavigationController {
        let vc = UINavigationController(rootViewController: viewController)
        vc.tabBarItem.title = tabBarTitle
        vc.tabBarItem.image = UIImage(named: tabBarImage)
        vc.navigationBar.barTintColor = .white
        vc.navigationBar.tintColor = .black
        vc.navigationBar.isTranslucent = false
        return vc
    }
    
}
