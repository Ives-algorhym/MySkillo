//
//  LoggingAdapter.swift
//  AppCore
//
//  Created by Ives Murillo on 6/10/26.
//

import Logging
import PlatformContracts

/// Bridges the platform `PlatformContracts.Logging` protocol to the concrete `Logging.Logger` infrastructure.
///
/// `LoggingAdapter` acts as an anti-corruption layer between the feature-facing logging contract
/// and the platform logging implementation. Features depend only on `PlatformContracts.Logging`;
/// the adapter is wired in `CompositionRoot` so the infrastructure detail stays out of domain code.
///
/// ## Usage
///
/// ```swift
/// let adapter = LoggingAdapter(logger: DefaultLogger(sinks: [InMemoryLogSink()]))
/// adapter.log("Session started")
/// ```
final class LoggingAdapter: PlatformContracts.Logging {
    private let logger: Logger

    /// Creates an adapter that forwards log messages to the given `Logger`.
    ///
    /// - Parameter logger: The concrete logger that receives forwarded log entries.
    init(logger: Logger) {
        self.logger = logger
    }

    /// Wraps `string` in a `LogEntry` and forwards it to the underlying logger.
    ///
    /// - Parameter string: The message to log.
    func log(_ string: String) {
        logger.log(LogEntry(message: string))
    }
}
