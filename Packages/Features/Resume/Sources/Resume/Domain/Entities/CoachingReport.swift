//
//  CoachingReport.swift
//  Resume
//
//  Created by Ives Murillo on 6/6/26.
//

import Foundation

struct CoachingReport: Equatable {
    static let maximunSuggestions = 3

    let takeID: UUID
    let overallScore: InterviewScore
    let dimensionScores: [DimensionScore]
    let suggestions: [Suggestion]
    let generatedAt: Date

    init?(
        takeID: UUID,
        overallScore: InterviewScore,
        dimensionScores: [DimensionScore],
        suggestions: [Suggestion],
        generatedAt: Date
    ) {
        guard suggestions.count <=  CoachingReport.maximunSuggestions else {
            return nil
        }

        self.takeID = takeID
        self.overallScore = overallScore
        self.dimensionScores = dimensionScores
        self.suggestions = suggestions
        self.generatedAt = generatedAt
    }
}
