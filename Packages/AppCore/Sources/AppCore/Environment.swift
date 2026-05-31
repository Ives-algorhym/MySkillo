//
//  Environment.swift
//
//
//  Created by Ives Murillo on 3/5/26.
//

/// Represents the runtime environment the application is running in.
///
/// `Environment` is registered in the `Container` at startup and can be resolved
/// by any dependency that needs to vary behavior between production and development
/// (e.g., selecting API base URLs, toggling feature flags, or adjusting log verbosity).
///
/// ## Usage
///
/// ```swift
/// try container.register(Environment.self) { _ in .production }
///
/// let env = try container.resolve(Environment.self)
/// print(env.name) // "production"
/// ```
public struct Environment: Sendable {
    /// A human-readable label identifying this environment (e.g., `"production"`, `"development"`).
    public let name: String

    /// The live environment used in App Store builds.
    public static let production = Environment(name: "production")

    /// The local development environment used during active development and debugging.
    public static let development = Environment(name: "development")
}
