//
//  TakeDurationTests.swift
//  Resume
//
//  Created by Ives Murillo on 7/20/26.
//

@testable import Resume
import Testing

@Suite("TakeDuration Tests")
struct TakeDurationTests {
    @Test("Cannot be created above maximum duration")
    func whenAboveMaximum_returnsNil() {
        #expect(TakeDuration(91) == nil)
    }

    @Test("Cannot be created below minimum duration")
    func whenBelowMinimum_returnsNil() {
        #expect(TakeDuration(0) == nil)
    }

    @Test("Can be created with valid duration")
    func whenValidDuration_succeeds() {
        #expect(TakeDuration(60) != nil)
    }

    @Test("Is in recommended range at lower boundary")
    func withLowerBoundaryOfRecommendedRange_isInRecommendedRange() throws {
        // Arrange
        let sut = try #require(TakeDuration(60))
        // Act & Assert
        #expect(sut.isRecommendedRange == true)
    }

    @Test("Is in recommended range at upper boundary")
    func withUpperBoundaryOfRecommendedRange_isInRecommendedRange() throws {
        // Arrange
        let sut = try #require(TakeDuration(90))
        // Act & Assert
        #expect(sut.isRecommendedRange == true)
    }

    @Test("Is not recommended range below 60 seconds")
    func withBelowRecommendedRange_isNotInRecommendedRange() throws {
        // Arrange
        let sut = try #require(TakeDuration(59))
        // Act & Assert
        #expect(sut.isRecommendedRange == false)
    }
}
