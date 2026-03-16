//
//  Logger.swift
//  Logging
//
//  Created by Ives Murillo on 3/16/26.
//

protocol LogSink {
  func write(_ entry: LogEntry)
}

protocol Logger {
  func log(_ entry: LogEntry)
}
