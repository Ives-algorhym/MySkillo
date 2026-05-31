//
//  Container.swift
//  AppCore
//
//  Created by Ives Murillo on 3/5/26.
//

import Foundation

/// A lightweight dependency injection container that maps types to factory closures.
///
/// `Container` stores factory closures keyed by type identity. Dependencies are registered
/// once and resolved on demand, with each call to `resolve` invoking the factory again
/// (i.e., no caching — factories produce a new instance on every resolution).
///
/// ## Usage
///
/// ```swift
/// let container = Container()
///
/// try container.register(NetworkService.self) { _ in
///     URLSessionNetworkService()
/// }
///
/// let service = try container.resolve(NetworkService.self)
/// ```
///
/// - Note: `Container` is not thread-safe. All registrations and resolutions should
///   occur on the same thread, typically the main thread via `@MainActor`.
public final class Container {
    private var factories: [ObjectIdentifier: (Container) throws -> Any] = [:]

    public init() {}

    /// Registers a factory closure for the given type.
    ///
    /// If a factory is already registered for `type`, it is silently replaced.
    ///
    /// - Parameters:
    ///   - type: The type to register. Used as the key for later resolution.
    ///   - factory: A closure that produces an instance of `type`. Receives the
    ///     container itself so it can resolve transitive dependencies.
    /// - Throws: Any error thrown by the factory closure during registration setup.
    func register<T>(_ type: T.Type, factory: @escaping (Container) throws -> T) throws {
        factories[ObjectIdentifier(type)] = { container in
            try factory(container)
        }
    }

    /// Resolves an instance of the given type from the container.
    ///
    /// Invokes the registered factory closure and returns the result cast to `T`.
    ///
    /// - Parameter type: The type to resolve.
    /// - Returns: An instance of `T` produced by the registered factory.
    /// - Throws: `ResolutionError.missingRegistration` if no factory has been registered
    ///   for `type`, or `ResolutionError.typeMismatch` if the factory returns a value
    ///   that cannot be cast to `T`.
    func resolve<T>(_ type: T.Type) throws -> T {
        guard let factory = factories[ObjectIdentifier(type)] else {
            throw ResolutionError.missingRegistration
        }

        guard let resolved = try factory(self) as? T else {
            throw ResolutionError.typeMismatch
        }

        return resolved
    }
}

/// Errors that can be thrown during dependency resolution.
enum ResolutionError: Error {
    /// No factory has been registered for the requested type.
    case missingRegistration
    /// The factory returned a value that could not be cast to the requested type.
    case typeMismatch
}
