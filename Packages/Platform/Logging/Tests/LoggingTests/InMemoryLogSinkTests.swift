//
//  InMemoryLogSinkTests.swift
//  Logging
//
//  Created by Ives Murillo on 3/16/26.
//

@testable import Logging
import Testing

@Suite("InMemory Sink Log Tests")
struct InMemoryLogSinkTests {
    @Test("InMemoryLogSink write and stores entry")
    func sinkWritesAndStoresEntry() {
        // Arrange
        let sink = InMemoryLogSink()
        let entry = LogEntry(message: "Hello")

        // Act
        sink.write(entry)
        // Assert
        #expect(sink.entries.count == 1)
        #expect(sink.entries.first?.message == "Hello")
    }

    @Test("InMemoryLogSink write and stores multiple entries in order")
    func sinkWritesAndStoresMultipleEntriesInOrder() {
        // Arrange
        let sink = InMemoryLogSink()
        let entry1 = LogEntry(message: "Hello log 1")
        let entry2 = LogEntry(message: "Hello log 2")

        // Act
        sink.write(entry1)
        sink.write(entry2)
        // Assert
        #expect(sink.entries.count == 2)
        #expect(sink.entries[0].message == "Hello log 1")
        #expect(sink.entries[1].message == "Hello log 2")
    }
}
