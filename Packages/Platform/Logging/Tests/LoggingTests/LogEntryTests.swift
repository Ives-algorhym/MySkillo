//
//  LogEntryTests.swift
//  Logging
//
//  Created by Ives Murillo on 3/16/26.
//

import Testing

@testable import Logging

@Suite("LogEntry Tests")
struct LogEntryTests {
  @Test("LogEntry preserves  initia message it was created with")
  func entryKeepsMessage() {
    // Arrange
    let sut = LogEntry(message: "Initial message")

    // Assert
    #expect(sut.message == "Initial message")
  }
}
