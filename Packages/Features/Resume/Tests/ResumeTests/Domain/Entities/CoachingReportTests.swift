//
//  CoachingReportTests.swift
//  Resume
//
//  Created by Ives Murillo on 6/30/26.
//

import Foundation
@testable import Resume
import Testing

@Suite("CoachingReport")
struct CoachingReportTests {
    @Suite("init")
    struct InitTests {
        let sugestion1 = Suggestion(
            dimension: .eyeContact,
            text: .init("keep eye contact")!
        )
        let sugestion2 = Suggestion(
            dimension: .fillerWords,
            text: .init("avoid filling words")!
        )
        let sugestion3 = Suggestion(
            dimension: .pacing,
            text: .init("pacing too fast")!
        )
        let sugestion4 = Suggestion(
            dimension: .structure,
            text: .init("improve struture")!
        )

        @Test("With more than limit suggestions fail")
        func init_withMoreThanLimitSuggestionsFail() {
            let suggestions = [sugestion1, sugestion2, sugestion3, sugestion4]
            // Act
            let sut = CoachingReportFactory.make(suggestion: suggestions)
            // Assert
            #expect(sut == nil)
        }

        @Test("with less or equal to limit of suggestions succed")
        func init_withLessOrEqualToLimitSuggestionsSucced() {
            // Assert
            let suggestions = [sugestion1, sugestion2, sugestion3]
            // Act
            let sut = CoachingReportFactory.make(suggestion: suggestions)
            // Assert
            #expect(sut != nil)
        }

        @Test("with zero suggestions succed")
        func init_withSZeroSuggestionsSucced() {
            // Act
            let sut = CoachingReportFactory.make(suggestion: [])
            // Assert
            #expect(sut != nil)
        }

        @Test("Has correct properties")
        func init_hasCorrectProperties() throws {
            // Arrange
            let takeId = UUID()
            let overallScore = try #require(InterviewScore(82))
            let dimensionScore = try #require(InterviewScore(82))
            let dimensionScores = [DimensionScore(dimension: .fillerWords, score: dimensionScore)]
            let generatedAt = Date()
            // Act
            let sut = CoachingReportFactory.make(
                takeID: takeId,
                overallScore: overallScore,
                dimensionScores: dimensionScores,
                generatedAt: generatedAt
            )
            // Assert
            #expect(sut?.takeID == takeId)
            #expect(sut?.overallScore == overallScore)
            #expect(sut?.dimensionScores == dimensionScores)
            #expect(sut?.generatedAt == generatedAt)
        }
    }
}

enum CoachingReportFactory {
    static func make(
        takeID: UUID = .init(),
        overallScore: InterviewScore = .init(82)!,
        dimensionScores: [DimensionScore] = [],
        suggestion: [Suggestion] = [],
        generatedAt: Date = .init()
    ) -> CoachingReport? {
        CoachingReport(
            takeID: takeID,
            overallScore: overallScore,
            dimensionScores: dimensionScores,
            suggestions: suggestion,
            generatedAt: generatedAt
        )
    }
}
