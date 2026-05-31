//
//  ResumeRegister.swift
//  AppCore
//
//  Created by Ives Murillo on 3/11/26.
//

import FeatureContracts
import Resume

/// Registers the Resume feature's dependencies into the app's dependency container.
///
/// `ResumeRegister` is a caseless enum used as a namespace — it cannot be instantiated,
/// which enforces that it is used solely as a static registration entry point via
/// `DependencyRegistering`. It is passed to `FeatureRegistry` at startup:
///
/// ```swift
/// let registry = FeatureRegistry(registrants: [ResumeRegister.self])
/// ```
@available(iOS 13.0, *)
public enum ResumeRegister: DependencyRegistering {
    /// Registers `ResumeFeatureProviding` in the container, backed by `ResumeFeature`.
    ///
    /// - Parameter container: The `Container` to register the Resume feature into.
    /// - Throws: `ResolutionError` if the registration cannot be stored in the container.
    @MainActor
    public static func register(in container: Container) throws {
        try container.register(ResumeFeatureProviding.self) { _ in
            ResumeFeature()
        }
    }
}
