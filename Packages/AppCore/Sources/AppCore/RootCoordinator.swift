//
//  RootCoordinator.swift
//  AppCore
//
//  Created by Ives Murillo on 3/9/26.
//

import UIKit

@MainActor
public protocol RootCoordinating {
    var rootViewController: UITabBarController { get }
    func start()
}

@MainActor
public class RootCoordinator: RootCoordinating {
    public private(set) var rootViewController: UITabBarController = RootTabViewController()
    public func start() {
        let rootViewController = UIViewController()
        rootViewController.tabBarItem = UITabBarItem(
            title: "Resume",
            image: nil,
            selectedImage: nil
        )

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [rootViewController]
        if tabBarController.viewControllers?.count == 1 {
            tabBarController.tabBar.isHidden = true
        }
        self.rootViewController = tabBarController
    }
}

final class RootTabViewController: UITabBarController {


}
