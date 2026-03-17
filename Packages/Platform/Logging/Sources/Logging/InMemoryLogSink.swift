//
//  InMemoryLogSink.swift
//  Logging
//
//  Created by Ives Murillo on 3/16/26.
//

public final class InMemoryLogSink: LogSink {
    public private(set) var entries: [LogEntry] = []

    public init() {}

    public func write(_ entry: LogEntry) {
        entries.append(entry)
    }
}
