//
//  MockNLPScorer.swift
//  Resume
//
//  Created by Ives Murillo on 7/22/26.
//

@testable import Resume
import Testing

/// In-memory test double for `NLPScorer`.
final class MockNLPScorer: NLPScorer {
    /// The result returned by `score(_:)`. Must be set before calling.
    var stubbedResult: DimensionScore?

    func score(_ transcript: TranscriptAnalysis) throws -> DimensionScore {
        try #require(stubbedResult)
    }
}
