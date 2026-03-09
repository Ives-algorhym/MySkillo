//
//  CompositionRootTests.swift
//  AppCore
//
//  Created by Ives Murillo on 3/6/26.
//

@testable import AppCore
import Testing
import UIKit

struct CompositionRootTests {
    @Test("bootstrap registers all feature dependencies into the container")
    func compositionRootRegisterFeatures() throws {
        let sut = CompositionRoot(
            environment: .development,
            registry: FeatureRegistry(registrants: [FeatureA.self])
        )

        let container = sut.container

        #expect(throws: Never.self) {
            _ = try container.resolve(ServiceA.self)
        }
    }

    @Test("bootstrap registers core dependencies before registering features")
    func compositionRootRegisterCoreDependencies() throws {
        let sut = CompositionRoot(
            environment: .development,
            registry: FeatureRegistry(registrants: [])
        )

        let container = sut.container

        #expect(throws: Never.self) {
            _ = try container.resolve(Environment.self)
        }
    }

    @Test("composition root caches the container instance")
    func compositionRootCachecontainer() {
        let sut = CompositionRoot(
            environment: .development,
            registry: FeatureRegistry(registrants: [])
        )

        let containerA = sut.container
        let containerB = sut.container

        #expect(containerA === containerB)
    }

    @MainActor
    @Test("composition root returns a root coordinator and coordinator expose root view controller")
    func rootReturnsRootCoordinator() throws {
        // arrange
        let sut = CompositionRoot(
            environment: .development,
            registry: FeatureRegistry(registrants: [])
        )

        // act

        let coordinator = sut.makeUIKitRoot()
        // assert
        #expect(coordinator.rootViewController is RootViewController)
    }

    @MainActor
    @Test("root coordinator start does not change root view controller")
    func rootCoordinatorStartDoesNBotReplaceRootViewController() throws {
        // arrange
        let sut = CompositionRoot(
            environment: .development,
            registry: FeatureRegistry(registrants: [])
        )

        // act

        let coordinator = sut.makeUIKitRoot()
        let rootBefore = coordinator.rootViewController

        coordinator.start()
        // assert
        #expect(coordinator.rootViewController ===
                rootBefore)
    }
}
