//
//  InMemoryLogSink.swift
//  Logging
//
//  Created by Ives Murillo on 3/16/26.
//

/// A ``LogSink`` that stores log entries in memory for inspection.
///
/// `InMemoryLogSink` is a **test double** — a concrete sink designed to be
/// used in unit tests instead of production sinks like a console or remote
/// service. After exercising code under test, you inspect `entries` to assert
/// that the right messages were logged.
///
/// ## Why a class, not a struct?
///
/// `InMemoryLogSink` is a `class` because it is passed into `DefaultLogger`
/// as `any LogSink` and then mutated (`entries.append`) from inside the logger.
/// If it were a `struct`, the logger would hold a copy — appending to that copy
/// would never be visible to your test. Using a reference type (`class`) means
/// both your test and `DefaultLogger` share the same instance, so mutations
/// are immediately observable.
///
/// This is a common Swift gotcha when working with protocols and value types:
/// **if you need shared, observable mutation, use a reference type.**
///
/// ## Usage in tests
///
/// ```swift
/// let sink = InMemoryLogSink()
/// let logger = DefaultLogger(sinks: [sink])
///
/// logger.log(LogEntry(message: "user tapped login"))
///
/// #expect(sink.entries.count == 1)
/// #expect(sink.entries[0].message == "user tapped login")
/// ```
///
/// ## `private(set)` on `entries`
///
/// The `entries` array is readable by anyone but writable only by
/// `InMemoryLogSink` itself. This enforces the invariant that entries are
/// only ever added through ``write(_:)`` — the proper ``LogSink`` interface —
/// never manipulated directly from outside.
///
/// - SeeAlso: ``LogSink``, ``LogEntry``, ``DefaultLogger``
public final class InMemoryLogSink: LogSink {
    /// The ordered list of entries written to this sink since it was created.
    public private(set) var entries: [LogEntry] = []

    /// Creates an empty in-memory sink.
    public init() {}

    /// Appends the entry to ``entries``.
    ///
    /// - Parameter entry: The log event to store.
    public func write(_ entry: LogEntry) {
        entries.append(entry)
    }
}
