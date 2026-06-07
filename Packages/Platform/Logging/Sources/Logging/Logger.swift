//
//  Logger.swift
//  Logging
//
//  Created by Ives Murillo on 3/16/26.
//

/// A destination that receives and persists structured log entries.
///
/// `LogSink` is the output side of the logging pipeline. Each sink decides
/// independently what to do with a `LogEntry` — write to the console, store
/// in memory, send to a remote service, etc.
///
/// ## Designing a sink
///
/// A sink should do one thing and do it well. Compose multiple sinks inside
/// `DefaultLogger` rather than building a sink that does many things.
///
/// ```swift
/// struct ConsoleSink: LogSink {
///     func write(_ entry: LogEntry) {
///         print("[\(entry.message)]")
///     }
/// }
/// ```
///
/// - Note: `InMemoryLogSink` is provided out of the box and is the recommended
///   sink to use in unit tests.
public protocol LogSink {
    /// Receives a structured log entry and handles its persistence or output.
    ///
    /// - Parameter entry: The log event to write.
    func write(_ entry: LogEntry)
}

/// An object that accepts structured log entries and dispatches them to one
/// or more ``LogSink`` destinations.
///
/// `Logger` is the internal contract of the `Logging` package. It works with
/// ``LogEntry`` — a structured value that can carry rich metadata — rather than
/// raw strings. This keeps the infrastructure layer decoupled from the simple
/// string-based ``PlatformContracts/Logging`` protocol that feature modules use.
///
/// ## Relationship to `PlatformContracts.Logging`
///
/// Feature modules depend on `PlatformContracts.Logging` (`func log(_ string: String)`),
/// not on this protocol. `AppCore` bridges the two by making `DefaultLogger`
/// conform to `PlatformContracts.Logging`, wrapping the incoming string into a
/// `LogEntry` before dispatching it through this pipeline.
///
/// ```
/// Feature  →  PlatformContracts.Logging  →  DefaultLogger  →  [LogSink]
/// ```
///
/// - SeeAlso: ``LogEntry``, ``LogSink``, ``DefaultLogger``
public protocol Logger {
    /// Dispatches a structured log entry to all configured sinks.
    ///
    /// - Parameter entry: The log event to dispatch.
    func log(_ entry: LogEntry)
}
