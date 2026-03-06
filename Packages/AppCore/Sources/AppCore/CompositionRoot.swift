//
//  CompositionRoot.swift
//  AppCore
//
//  Created by Ives Murillo on 3/6/26.
//

import Foundation
import UIKit

public class CompositionRoot {
    private let environment: Environment
    private let registry: FeatureRegistry

    private(set) lazy var container: Container = {
        let container = Container()

        container.register(Environment.self) { _ in
            self.environment
        }

        registry.registerAll(in: container)
        return container
    }()

    init(environment: Environment, registry: FeatureRegistry) {
        self.environment = environment
        self.registry = registry
    }

    @MainActor func makeUIKitRoot() -> UIViewController {
        return .init()
    }
}
