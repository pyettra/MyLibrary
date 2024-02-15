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

        // Create your view controllers
        let firstVC = ViewController(interactor: interactor)
//        let secondVC = BookViewController()
        
        presenter.viewController = firstVC

        // Create an instance of UITabBarController
        let tabBarController = UITabBarController()
        
        // Set view controllers for the UITabBarController
        tabBarController.viewControllers = [firstVC]
        
        tabBarController.tabBar.backgroundColor = .white
        
        tabBarController.view.frame = view.bounds

        // Add the UITabBarController as a child view controller
        addChild(tabBarController)
        view.addSubview(tabBarController.view)
        tabBarController.didMove(toParent: self)
    }
}
