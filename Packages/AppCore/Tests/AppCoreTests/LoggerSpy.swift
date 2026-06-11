//
//  LoggerSpy.swift
//  AppCore
//
//  Created by Ives Murillo on 6/10/26.
//

import Logging

class LoggerSpy: Logger {
    private(set) var receivedEntries: [LogEntry] = []
    var receivedMessages: [String] {
        receivedEntries.map(\.message)
    }

    func log(_ entry: Logging.LogEntry) {
        receivedEntries.append(entry)
    }
}
