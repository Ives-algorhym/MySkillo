//
//  RootCoordinator.swift
//  AppCore
//
//  Created by Ives Murillo on 3/9/26.
//

import FeatureContracts
import UIKit

/// Defines the interface for the object that owns the app's root `UITabBarController`
/// and manages its initial setup.
///
/// Abstracting the coordinator behind a protocol allows `CompositionRoot` and tests to
/// depend on the interface rather than the concrete `RootCoordinator` class.
@MainActor
public protocol RootCoordinating {
    /// The tab bar controller that should be set as the window's `rootViewController`.
    ///
    /// Before `start()` is called this holds a placeholder; after `start()` it holds
    /// the fully configured controller with all feature tabs installed.
    var rootViewController: UITabBarController { get }

    /// Builds the tab bar hierarchy and installs feature view controllers.
    ///
    /// Call this once, before assigning `rootViewController` to the window.
    func start()
}

/// Concrete coordinator that assembles the app's root tab bar from registered feature providers.
///
/// `RootCoordinator` is created by `CompositionRoot.makeUIKitRoot()` with the resolved
/// feature providers injected via its initializer. Calling `start()` asks each provider
/// for its view controller, wraps them in a `UITabBarController`, and hides the tab bar
/// when only one tab is present.
@MainActor
public class RootCoordinator: RootCoordinating {
    /// The root tab bar controller vended to the window.
    ///
    /// Replaced with a fully configured instance when `start()` is called.
    public private(set) var rootViewController: UITabBarController = RootTabViewController()
    private let resumeProvider: ResumeFeatureProviding

    /// Creates a coordinator with the given feature providers.
    ///
    /// - Parameter resumeProvider: The provider that creates the Resume feature's root view controller.
    public init(
        resumeProvider: ResumeFeatureProviding
    ) {
        self.resumeProvider = resumeProvider
    }

    /// Builds the tab bar hierarchy and updates `rootViewController`.
    ///
    /// Requests a view controller from each feature provider, assigns tab bar items,
    /// and hides the tab bar when only a single tab is present.
    /// Must be called before the window presents `rootViewController`.
    public func start() {
        let rootViewController = resumeProvider.makeResumeViewController()

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
