//
//  DefaultLogger.swift
//  Logging
//
//  Created by Ives Murillo on 3/16/26.
//

/// The default concrete implementation of ``Logger``.
///
/// `DefaultLogger` is the orchestrator of the logging pipeline. It holds a
/// list of ``LogSink`` destinations and forwards every ``LogEntry`` it receives
/// to each of them in order.
///
/// ## Design: composition over inheritance
///
/// `DefaultLogger` does not decide *where* logs go — that responsibility
/// belongs to the sinks injected at creation time. This is the
/// **Strategy pattern**: the behavior (output destination) is swapped in from
/// the outside rather than hard-coded. Adding a new output (e.g. a file sink,
/// a remote sink) requires zero changes to `DefaultLogger`.
///
/// ## Usage
///
/// ```swift
/// // Production: console + remote
/// let logger = DefaultLogger(sinks: [ConsoleSink(), RemoteSink()])
///
/// // Tests: capture output in memory
/// let sink = InMemoryLogSink()
/// let logger = DefaultLogger(sinks: [sink])
/// logger.log(LogEntry(message: "hello"))
/// assert(sink.entries.count == 1)
/// ```
///
/// ## Why `final`?
///
/// Marking the class `final` signals that `DefaultLogger` is not designed to
/// be subclassed. Behavior should be extended by composing sinks, not by
/// inheriting and overriding. `final` also allows the compiler to use static
/// dispatch for method calls, which is a small but real performance win.
///
/// ## Wiring to `PlatformContracts.Logging`
///
/// Feature modules depend on the thin `PlatformContracts.Logging` contract
/// (`func log(_ string: String)`), not on `DefaultLogger` directly. `AppCore`
/// bridges the two with a conformance extension:
///
/// ```swift
/// extension DefaultLogger: PlatformContracts.Logging {
///     public func log(_ string: String) {
///         log(LogEntry(message: string))
///     }
/// }
/// ```
///
/// - SeeAlso: ``Logger``, ``LogSink``, ``LogEntry``, ``InMemoryLogSink``
public final class DefaultLogger: Logger {
    private let sinks: [any LogSink]

    /// Creates a logger that dispatches entries to the given sinks.
    ///
    /// Pass an empty array to create a no-op logger that silently discards
    /// all entries — useful in previews or placeholder contexts.
    ///
    /// - Parameter sinks: The output destinations that will receive each
    ///   ``LogEntry``. Entries are forwarded in the order sinks appear in
    ///   this array.
    public init(sinks: [any LogSink]) {
        self.sinks = sinks
    }

    /// Forwards the entry to every configured sink in order.
    ///
    /// - Parameter entry: The log event to dispatch.
    public func log(_ entry: LogEntry) {
        for sink in sinks {
            sink.write(entry)
        }
    }
}
