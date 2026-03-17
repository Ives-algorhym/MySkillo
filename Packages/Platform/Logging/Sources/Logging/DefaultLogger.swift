//
//  DefaultLogger.swift
//  Logging
//
//  Created by Ives Murillo on 3/16/26.
//

public final class DefaultLogger: Logger {
    private let sinks: [any LogSink]

    public init(sinks: [any LogSink]) {
        self.sinks = sinks
    }

    public func log(_ entry: LogEntry) {
        for sink in sinks {
            sink.write(entry)
        }
    }
}
