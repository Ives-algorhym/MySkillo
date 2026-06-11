//
//  LoggingAdapterTests.swift
//  AppCore
//
//  Created by Ives Murillo on 6/10/26.
//

import Testing
import Logging
@testable import AppCore

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
}
