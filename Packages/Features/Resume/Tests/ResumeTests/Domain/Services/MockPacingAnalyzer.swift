//
//  MockPacingAnalyzer.swift
//  Resume
//
//  Created by Ives Murillo on 7/22/26.
//

@testable import Resume
import Testing

/// In-memory test double for `PacingAnalyzer`.
final class MockPacingAnalyzer: PacingAnalyzer {
    /// The result returned by `analyze(_:)`. Must be set before calling.
    var stubbedResult: DimensionScore?

    func analyze(_: TranscriptAnalysis) throws -> DimensionScore {
        try #require(stubbedResult)
    }
}
