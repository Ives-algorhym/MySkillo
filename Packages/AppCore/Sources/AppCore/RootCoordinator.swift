//
//  RootCoordinator.swift
//  AppCore
//
//  Created by Ives Murillo on 3/9/26.
//

import UIKit

@MainActor
public protocol RootCoordinating {
    var rootViewController: UIViewController { get }
    func start()
}

@MainActor
public struct RootCoordinator: RootCoordinating {
    public let rootViewController: UIViewController = RootViewController()
    public func start() {}
}

final class RootViewController: UIViewController {}
