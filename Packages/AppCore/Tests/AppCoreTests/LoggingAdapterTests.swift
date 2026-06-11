//
//  LoggingAdapterTests.swift
//  AppCore
//
//  Created by Ives Murillo on 6/10/26.
//

@testable import AppCore
import Logging
import Testing

@Suite("Logging Adapter Tests")
struct LoggingAdapterTests {
    @Suite("Log")
    struct LogTest {
        @Test
        func forwaresMessageToLogger() {
            // Arrange
            let spy = LoggerSpy()
            let sut = LoggingAdapter(logger: spy)
            // Act
            sut.log("Test message")
            // Assert
            #expect(spy.receivedMessages == ["Test message"])
        }
    }

    @Test
    func forwardsMultipleMessages() {
        // Arrange
        let spy = LoggerSpy()
        let sut = LoggingAdapter(logger: spy)
        // Act
        sut.log("First message")
        sut.log("Second message")
        sut.log("Third message")
        // Assert
        #expect(spy.receivedMessages == ["First message", "Second message", "Third message"])
    }
}
