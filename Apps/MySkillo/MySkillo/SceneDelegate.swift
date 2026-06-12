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

        #if DEBUG
        let environment = Environment.development
        #else
        let environment = Environment.production
        #endif

        let root = CompositionRoot(
            environment: environment,
            registry: FeatureRegistry(registrants: [ResumeRegister.self])
        )

        let coordinator = root.makeUIKitRoot()

        coordinator.start()

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = coordinator.rootViewController
        window.makeKeyAndVisible()
        self.window = window
    }
}
