//
//  WordsPerMinuteTests.swift
//  Resume
//
//  Created by Ives Murillo on 7/20/26.
//

@testable import Resume
import Testing

@Suite("WordsPerMinute Tests")
struct WordsPerMinuteTests {
    @Test("Cannot be construced with zero value")
    func withZeroValue_returnsNil() {
        // Act & Assert
        #expect(WordsPerMinute(0) == nil)
    }

    @Test("Cannot be construced with negative value")
    func withNegativeValue_returnsNil() {
        // Act & Assert
        #expect(WordsPerMinute(-1) == nil)
    }

    @Test("Cannot be construced with above maximum 300 wpm")
    func withGreaterThanMaximumValue_returnsNil() {
        // Act & Assert
        #expect(WordsPerMinute(301) == nil)
    }

    @Test("Can be construced with valid value")
    func withValidValue_returnsValue() {
        // Act & Assert
        #expect(WordsPerMinute(140) != nil)
    }

    @Test("Pacing is ideal for lower boundary of ideal range")
    func withLowerBoundaryOfIdealRange_returnsIdeal() throws {
        // Arrange
        let sut = try #require(WordsPerMinute(130))
        // Act & Assert
        #expect(sut.pacingAssessment == .ideal)
    }

    @Test("Pacing is ideal for upper boundary of ideal range")
    func withUpperBoundaryOfIdealRange_returnsIdeal() throws {
        // Arrange
        let sut = try #require(WordsPerMinute(160))
        // Act & Assert
        #expect(sut.pacingAssessment == .ideal)
    }

    @Test("Pacing is slightly below ideal at lower boundary")
    func withLowerBoundaryOfSlightlyBelowRange_returnsSlightlyBelowRange() throws {
        // Arrange
        let sut = try #require(WordsPerMinute(100))
        // Act & Assert
        #expect(sut.pacingAssessment == .slightlyBelowIdeal)
    }

    @Test("Pacing is slightly below ideal at upper boundary")
    func withUpperBoundaryOfSlightlyBelowRange_returnsSlightlyBelowRange() throws {
        // Arrange
        let sut = try #require(WordsPerMinute(129))
        // Act & Assert
        #expect(sut.pacingAssessment == .slightlyBelowIdeal)
    }

    @Test("Pacing is slightly above ideal at lower boundary")
    func withLowerBoundaryOfSlightlyAboveRange_returnsSlightlyAboveRange() throws {
        // Arrange
        let sut = try #require(WordsPerMinute(161))
        // Act & Assert
        #expect(sut.pacingAssessment == .slightlyAboveIdeal)
    }

    @Test("Pacing is slightly above ideal at upper boundary")
    func withUpperBoundaryOfSlightlyAboveRange_returnsSlightlyAboveRange() throws {
        // Arrange
        let sut = try #require(WordsPerMinute(180))
        // Act & Assert
        #expect(sut.pacingAssessment == .slightlyAboveIdeal)
    }

    @Test("Pacing is too fast at lower boundary")
    func withLowerBoundaryOfTooFastRange_returnsTooFastRange() throws {
        // Arrange
        let sut = try #require(WordsPerMinute(181))
        // Act & Assert
        #expect(sut.pacingAssessment == .tooFast)
    }

    @Test("Pacing is too fast at upper boundary")
    func withUpperBoundaryOfTooFastRange_returnsTooFastRange() throws {
        // Arrange
        let sut = try #require(WordsPerMinute(300))
        // Act & Assert
        #expect(sut.pacingAssessment == .tooFast)
    }

    @Test("Pacing is too slow at lower boundary")
    func withLowerBoundaryOfTooSlowRange_returnsTooSlowRange() throws {
        // Arrange
        let sut = try #require(WordsPerMinute(1))
        // Act & Assert
        #expect(sut.pacingAssessment == .tooSlow)
    }

    @Test("Pacing is too slow at upper boundary")
    func withUpperBoundaryOfTooSlowRange_returnsTooSlowRange() throws {
        // Arrange
        let sut = try #require(WordsPerMinute(99))
        // Act & Assert
        #expect(sut.pacingAssessment == .tooSlow)
    }
}
