//
//  DefaultLoggerTests.swift
//  Logging
//
//  Created by Ives Murillo on 3/16/26.
//

import Testing

@testable import Logging

@Suite("Default Logger Tests")
struct DefaultLoggerTests {

  @Test("default logger forwards entry to sink")
  func defaultLoggerForwardsEntryToSink() {
    // Design note:
    // DefaultLogger should depend on a LogSink abstraction so sinks can vary.
    // Arrange
    let sink = InMemoryLogSink()
    let logger = DefaultLogger(sinks: [sink])
    let entry = LogEntry(message: "Hello")

    // Act
    logger.log(entry)
    // Assert
    #expect(sink.entries.count == 1)
  }

  @Test("default logger forwards multiple entries to sink in order")
  func defaultLoggerForwardsMultpleEntriesToSinkInOrder() {
    // Arrange
    let sink = InMemoryLogSink()
    let logger = DefaultLogger(sinks: [sink])
    let entry1 = LogEntry(message: "Hello log 1")
    let entry2 = LogEntry(message: "Hello log 2")

    // Act
    logger.log(entry1)
    logger.log(entry2)
    // Assert
    #expect(sink.entries.count == 2)
    #expect(sink.entries[0].message == "Hello log 1")
    #expect(sink.entries[1].message == "Hello log 2")
  }

  @Test("default logger forwards entry to all cnfigured sinks")
  func defaultLoggerForwardsEntryToAllSinks() {
    // Design note:
    // DefaultLogger should depend on a LogSink abstraction so sinks can vary.
    // Arrange
    let sink1 = InMemoryLogSink()
    let sink2 = InMemoryLogSink()
    let logger = DefaultLogger(sinks: [sink1, sink2])
    let entry = LogEntry(message: "Hello")

    // Act
    logger.log(entry)
    // Assert
    #expect(sink1.entries.count == 1)
    #expect(sink1.entries[0].message == "Hello")
    #expect(sink2.entries.count == 1)
    #expect(sink2.entries[0].message == "Hello")
  }

  @Test("default logger forwards entry to sink")
  func defaultNotFailIfHasNotCnfiguredSinks() {
    // Design note:
    // DefaultLogger should depend on a LogSink abstraction so sinks can vary.
    // Arrange

    let logger = DefaultLogger(sinks: [])
    let entry = LogEntry(message: "Hello")

    // Act
    logger.log(entry)
    // Assert
    #expect(true)
  }
}
