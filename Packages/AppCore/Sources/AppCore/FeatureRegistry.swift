//
//  FeatureRegistry.swift
//
//
//  Created by Ives Murillo on 3/5/26.
//

public struct FeatureRegistry {
    private let registrants: [DependnencyRegistering.Type]

    public init(registrants: [DependnencyRegistering.Type]) {
        self.registrants = registrants
    }

    public func registerAll(in container: Container) {
        for registrant in registrants {
            registrant.register(in: container)
        }
    }
}
