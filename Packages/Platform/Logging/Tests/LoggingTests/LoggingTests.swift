//
//  LoggingTests.swift
//  Logging
//
//  Created by Ives Murillo on 3/10/26.
//

@testable import Logging
import Testing

@Suite("Loggin feature Integration tests")
struct LoggingTests {
    @Test("logger can be injected into a client")
    func loggerCanBeInjectedIntoClient() {
        // Arrange
        let sink = InMemoryLogSink()
        let logger = DefaultLogger(sinks: [sink])
        let client = LoggerClient(logger: logger)
        // Act
        client.doWork()

        // Assert
        #expect(sink.entries.count == 1)
        #expect(sink.entries[0].message == "Client log")

    }
}

struct LoggerClient {
    let logger: any Logger
    func doWork() {
        logger.log(.init(message: "Client log"))
    }
}
