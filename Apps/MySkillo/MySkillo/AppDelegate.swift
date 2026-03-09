//
//  AppDelegate.swift
//  MySkillo
//
//  Created by Ives Murillo on 3/5/26.
//

import AppCore
import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        _ = application
        _ = launchOptions
        return true
    }

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        _ = application
        _ = connectionOptions
        return UISceneConfiguration(
            name: "Default Configuration",
            sessionRole: connectingSceneSession.role
        )
    }
}
