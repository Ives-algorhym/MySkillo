//
//  InMemoryLogSink.swift
//  Logging
//
//  Created by Ives Murillo on 3/16/26.
//

final class InMemoryLogSink: LogSink {
    private(set) var entries: [LogEntry] = []

    func write(_ entry: LogEntry) {
        entries.append(entry)
    }
}
