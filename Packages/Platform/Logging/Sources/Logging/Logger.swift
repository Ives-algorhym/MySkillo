//
//  Logger.swift
//  Logging
//
//  Created by Ives Murillo on 3/16/26.
//

public protocol LogSink {
    func write(_ entry: LogEntry)
}

public protocol Logger {
    func log(_ entry: LogEntry)
}
