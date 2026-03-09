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
    
    @Test("composition root returns the cached container on subsequent access")
    func compositionRootRcontainer() {
        let sut = CompositionRoot(
            environment: .development,
            registry: FeatureRegistry(registrants: [])
        )

        let containerA = sut.container
        let containerB = sut.container

        #expect(containerA === containerB)
    }
}
