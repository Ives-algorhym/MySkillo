//
//  LoggingTests.swift
//  PlatformContracts
//
//  Created by Ives Murillo on 3/17/26.
//

@testable import PlatformContracts
import Testing

@Suite("Logging contract tests")
struct LoggingTests {
    @Test("log can be called from protocol")
    func logCanBeCalledFromProtocol() {
        // Arrange
        let sut: Logging = LoggerSpy()
        // Act
        sut.log("Logged")
        // Assert
        #expect(true)
    }
}

struct LoggerSpy: Logging {
    func log(_: String) {}
}
