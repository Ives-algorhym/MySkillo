//
//  LogEntry.swift
//  Logging
//
//  Created by Ives Murillo on 3/16/26.
//

/// An immutable value that represents a single log event in the system.
///
/// `LogEntry` is the core domain model of the `Logging` package. It is the
/// structured record that travels through the pipeline from a ``Logger`` to
/// one or more ``LogSink`` destinations.
///
/// ## Why a value type?
///
/// Using a `struct` makes each log event an independent, immutable snapshot.
/// Once created, a `LogEntry` cannot be mutated — sinks receive exactly what
/// was logged, with no risk of data races or accidental mutation as it passes
/// through the pipeline. This is a key Swift pattern: model data as values,
/// not references.
///
/// ## Why not just a `String`?
///
/// A raw string carries only the message. `LogEntry` is the place where richer
/// metadata will live as the logging system grows — things like severity level,
/// subsystem, category, source location, and timestamp. Encapsulating all of
/// that in one type keeps ``LogSink`` implementations simple: they receive one
/// value and decide what to do with it.
///
/// ## Planned evolution
///
/// Today `LogEntry` holds only a `message`. Future iterations will add:
/// - `level: Level` — debug / info / warning / error
/// - `subsystem: String` — mirrors `OSLog`'s subsystem concept
/// - `category: String` — mirrors `OSLog`'s category concept
/// - `timestamp: Date` — when the event occurred
/// - `file`, `function`, `line` — source location via `#file`, `#function`, `#line`
///
/// - SeeAlso: ``Logger``, ``LogSink``
public struct LogEntry {
    /// The human-readable description of the log event.
    public let message: String

    /// Creates a new log entry with the given message.
    ///
    /// - Parameter message: A human-readable description of the event being logged.
    public init(message: String) {
        self.message = message
    }
}
