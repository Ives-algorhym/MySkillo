//
//  LogEntryTests.swift
//  Logging
//
//  Created by Ives Murillo on 3/16/26.
//

@testable import Logging
import Testing

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
