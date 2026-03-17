//
//  DefaultLogger.swift
//  Logging
//
//  Created by Ives Murillo on 3/16/26.
//

final class DefaultLogger: Logger {
    private let sinks: [any LogSink]

    init(sinks: [any LogSink]) {
        self.sinks = sinks
    }

    func log(_ entry: LogEntry) {
        for sink in sinks {
            sink.write(entry)
        }
    }
}
