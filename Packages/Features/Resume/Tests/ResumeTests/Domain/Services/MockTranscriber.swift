//
//  MockTranscriber.swift
//  Resume
//
//  Created by Ives Murillo on 7/21/26.
//

@testable import Resume
import Testing

/// In-memory test double for `TakeTranscriber`.
actor MockTakeTranscriber: TakeTranscriber {
    /// Number of times `transcribe(_:)` has been called.
    private(set) var transcribeCallCount: Int = 0

    /// The result returned by `transcribe(_:)`. Must be set before calling.
    var stubbedResult: TranscriptAnalysis?

    func transcribe(_ take: Take) async throws -> TranscriptAnalysis {
        transcribeCallCount += 1
        return try #require(stubbedResult)
    }
}
