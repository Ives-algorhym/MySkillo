//
//  File.swift
//  AppCore
//
//  Created by Ives Murillo on 3/6/26.
//

import Testing
import UIKit
@testable import AppCore

@Suite("Composition root tests")
struct CompositionRootTests {
    @MainActor
    @Test("make UIKitRoot returns a ViewController")
    func makeUIKitRootReturnsViewController() async throws {

        let sut = CompositionRoot(environment: .development, registry: FeatureRegistry(
            registrants: []
        ))

        _ = sut.makeUIKitRoot()

    }

    @Test("Composition root register features into the container")
    func compositionRootRegisterFeatures() throws {
        let sut = CompositionRoot(
            environment: .development,
            registry: FeatureRegistry(registrants: [FeatureA.self])
        )

        let container = sut.container

        _ = try container.resolve(ServiceA.self)
    }

    @Test("Composition root register first core dependencies into the container")
    func compositionRootRegisterCoreDependencies() throws {
        let sut = CompositionRoot(
            environment: .development,
            registry: FeatureRegistry(registrants: [])
        )

        let container = sut.container

        _ = try container.resolve(Environment.self)
    }

    @Test("Composition root cache container")
    func compositionRootCachecontainer() throws {
        let sut = CompositionRoot(
            environment: .development,
            registry: FeatureRegistry(registrants: [])
        )

        let containerA = sut.container
        let containerB = sut.container

        #expect(containerA === containerB)
    }

    @Test("Composition root cache container")
    func compositionRootRcontainer() throws {
        let sut = CompositionRoot(
            environment: .development,
            registry: FeatureRegistry(registrants: [])
        )

        let containerA = sut.container
        let containerB = sut.container

        #expect(containerA === containerB)
    }
}
