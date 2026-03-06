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
        registrants.forEach {
            $0.register(in: container)
        }
    }
}
