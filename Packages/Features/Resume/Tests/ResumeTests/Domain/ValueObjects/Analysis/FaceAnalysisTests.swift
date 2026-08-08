//
//  FaceAnalysisTests.swift
//  Resume
//
//  Created by Ives Murillo on 7/21/26.
//

@testable import Resume
import Testing

@Suite("FaceAnalysis Tests")
struct FaceAnalysisTests {
    @Test("Has correct properties")
    func hasCorrectProperties() throws {
        // Arrange
        let eyeContact = try #require(InterviewScore(88))
        let expressionScore = try #require(InterviewScore(75))
        let headMovementScore = try #require(InterviewScore(82))

        // Act
        let sut = FaceAnalysis(
            eyeContact: eyeContact,
            expressionScore: expressionScore,
            headMovementScore: headMovementScore
        )

        // Assert
        #expect(sut.eyeContact == eyeContact)
        #expect(sut.expressionScore == expressionScore)
        #expect(sut.headMovementScore == headMovementScore)
    }
}
