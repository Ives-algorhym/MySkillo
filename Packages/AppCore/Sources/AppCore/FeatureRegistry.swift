//
//  FeatureRegistry.swift
//
//
//  Created by Ives Murillo on 3/5/26.
//

public struct FeatureRegistry {
    private let registrants: [DependencyRegistering.Type]

    public init(registrants: [DependencyRegistering.Type]) {
        self.registrants = registrants
    }

    @MainActor
    public func registerAll(in container: Container) throws {
        for registrant in registrants {
            try registrant.register(in: container)
        }
    }
}
