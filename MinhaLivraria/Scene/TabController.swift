//
//  TabController.swift
//  MinhaLivraria
//
//  Created by Pyettra Ferreira on 15/02/24.
//

import Foundation
import UIKit

final class TabBarController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let presenter = Presenter()
        
        let interactor = Interactor(presenter: presenter)

        let firstVC = ViewController(interactor: interactor)
        let secondVC = WishListViewController()
        let thirdVC = ReadViewController()
        
        let navigationController = UINavigationController(rootViewController: firstVC)
        let secondNavigationController = UINavigationController(rootViewController: secondVC)
        let thirdNavigationController = UINavigationController(rootViewController: thirdVC)
        
        presenter.viewController = firstVC

        let tabBarController = UITabBarController()
        
        tabBarController.viewControllers = [
            navigationController,
            secondNavigationController,
            thirdNavigationController
        ]
        
        tabBarController.tabBar.backgroundColor = .white
        
        tabBarController.view.frame = view.bounds

        // Add the UITabBarController as a child view controller
        addChild(tabBarController)
        view.addSubview(tabBarController.view)
        tabBarController.didMove(toParent: self)
    }
}
