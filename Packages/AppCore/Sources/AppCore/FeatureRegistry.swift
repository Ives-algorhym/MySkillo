//
//  FeatureRegistry.swift
//
//
//  Created by Ives Murillo on 3/5/26.
//

/// A collection of feature module registrants that bulk-register dependencies into a `Container`.
///
/// `FeatureRegistry` acts as a coordination layer between `CompositionRoot` and individual
/// feature modules. Each feature provides a type conforming to `DependencyRegistering`;
/// the registry holds those types and calls them in order during container setup.
///
/// ## Usage
///
/// ```swift
/// let registry = FeatureRegistry(registrants: [ResumeRegister.self])
/// try registry.registerAll(in: container)
/// ```
public struct FeatureRegistry {
    private let registrants: [DependencyRegistering.Type]

    /// Creates a registry with the given list of dependency registrants.
    ///
    /// - Parameter registrants: An ordered list of `DependencyRegistering` metatypes.
    ///   Dependencies are registered in the order they appear in this array.
    public init(registrants: [DependencyRegistering.Type]) {
        self.registrants = registrants
    }

    /// Calls `register(in:)` on each registrant in order, populating the container.
    ///
    /// Registration stops and rethrows immediately if any registrant throws an error.
    ///
    /// - Parameter container: The `Container` to register dependencies into.
    /// - Throws: Any error thrown by a registrant's `register(in:)` implementation.
    @MainActor
    public func registerAll(in container: Container) throws {
        for registrant in registrants {
            try registrant.register(in: container)
        }
    }
}
