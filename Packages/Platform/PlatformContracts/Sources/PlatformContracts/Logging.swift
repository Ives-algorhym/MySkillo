//
//  Logging.swift
//  PlatformContracts
//
//  Created by Ives Murillo on 3/17/26.
//

/// A platform-level abstraction for logging.
///
/// `Logging` is the shared contract that all feature modules should depend on
/// when they need to emit log messages. It intentionally keeps a minimal surface
/// area — a single `log(_:)` method — so features stay decoupled from any
/// concrete logging implementation (e.g. `DefaultLogger` from the `Logging` package).
///
/// ## Dependency inversion
///
/// Feature modules import `PlatformContracts` and declare a dependency on `any Logging`.
/// The composition root (`AppCore`) resolves and injects the concrete implementation.
/// This means a feature never needs to know *how* messages are written — only *that*
/// it can write them.
///
/// ## Usage
///
/// ### In a feature module
///
/// ```swift
/// import PlatformContracts
///
/// struct MyFeature {
///     private let logger: any Logging
///
///     init(logger: any Logging) {
///         self.logger = logger
///     }
///
///     func doSomething() {
///         logger.log("MyFeature: doSomething called")
///     }
/// }
/// ```
///
/// ### Providing a concrete implementation (composition root)
///
/// ```swift
/// try container.register(Logging.self) { _ in
///     DefaultLogger()
/// }
/// ```
///
/// ### In tests (using a spy)
///
/// ```swift
/// struct LoggerSpy: Logging {
///     var messages: [String] = []
///     mutating func log(_ string: String) { messages.append(string) }
/// }
/// ```
///
/// - Note: Conform concrete loggers to this protocol inside `AppCore` or a dedicated
///   adapter — never inside the feature module itself.
public protocol Logging {
    /// Emits a log message.
    ///
    /// - Parameter string: The human-readable message to log.
    func log(_ string: String)
}
