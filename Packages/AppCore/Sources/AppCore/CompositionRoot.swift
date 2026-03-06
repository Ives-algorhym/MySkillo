//
//  File.swift
//  AppCore
//
//  Created by Ives Murillo on 3/6/26.
//

import Foundation
import UIKit

public class CompositionRoot {
    private let environment: Environment
    private let registry: FeatureRegistry

    private(set) lazy var continer: Continer = {
        let continer = Continer()

        continer.register(Environment.self) { _ in
            self.environment
        }

        registry.registerAll(in: continer)
        return continer
    }()

    init(environment: Environment, registry: FeatureRegistry) {
        self.environment = environment
        self.registry = registry
    }

    @MainActor func makeUIKitRoot() -> UIViewController {
        return .init()
    }
}
