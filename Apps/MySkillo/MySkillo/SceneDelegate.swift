//
//  SceneDelegate.swift
//  MySkillo
//
//  Created by Ives Murillo on 3/5/26.
//

import AppCore
import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo _: UISceneSession,
        options _: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }

        let root = CompositionRoot(
            environment: .development,
            registry: FeatureRegistry(registrants: [])
        )

        let coordinator = root.makeUIKitRoot()
        coordinator.start()

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = coordinator.rootViewController
        window.makeKeyAndVisible()
        self.window = window
    }
}
