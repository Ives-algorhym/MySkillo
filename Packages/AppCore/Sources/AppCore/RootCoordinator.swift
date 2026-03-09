//
//  RootCoordinator.swift
//  AppCore
//
//  Created by Ives Murillo on 3/9/26.
//

import UIKit

@MainActor
protocol RootCoordinating {
    var rootViewController: UIViewController { get }
    func start()
}

@MainActor
struct RootCoordinator: RootCoordinating {
    let rootViewController: UIViewController = RootViewController()
    func start() {

    }
}

final class RootViewController: UIViewController {}
