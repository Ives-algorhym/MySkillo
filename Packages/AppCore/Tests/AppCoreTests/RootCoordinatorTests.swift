//
//  RootCoordinatorTests.swift
//  AppCore
//
//  Created by Ives Murillo on 3/9/26.
//

@testable import AppCore
import FeatureContracts
import Testing
import UIKit

struct RootCoordinatorTests {
    @MainActor
    @Test("start sets resume as a root view and just one tab")
    func startSetsResumeAsRoot() {
        // Arrange
        let stub = StubResumeProvider()
        let sut = RootCoordinator(resumeProvider: stub)

        // Act
        sut.start()
        let root = sut.rootViewController

        // Assert
        #expect(root.viewControllers?.first == stub.lastBuildViewController)
        #expect(root.tabBar.isHidden == true)
    }
}

final class StubResumeProvider: ResumeFeatureProviding {
    var lastBuildViewController: UIViewController?

    func makeResumeViewController() -> UIViewController {
        let controller = UIViewController()
        lastBuildViewController = controller
        return controller
    }
}
