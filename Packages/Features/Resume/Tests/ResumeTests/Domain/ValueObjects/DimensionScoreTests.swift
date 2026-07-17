//
//  DimensionScoreTests.swift
//  Resume
//
//  Created by Ives Murillo on 7/1/26.
//

@testable import Resume
import Testing

@Suite("DimensionScore")
struct DimensionScoreTests {
    @Test("DimensionScore has correct properties")
    func hasCorrectProperties() throws {
        // Arrange
        let score = try #require(InterviewScore(10))
        let sut = DimensionScore(dimension: .technicalDepth, score: score)
        // Act-Assert
        #expect(sut.dimension == .technicalDepth)
        #expect(sut.score == score)
    }
}
