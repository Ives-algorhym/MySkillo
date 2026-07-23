//
//  MockFieldDictationService.swift
//  Resume
//
//  Created by Ives Murillo on 7/22/26.
//

@testable import Resume
import Testing

/// In-memory test double for `FieldDictationService`.
actor MockFieldDictationService: FieldDictationService {
    /// The stream returned by `startDictation()`. Must be set before calling.
    var stubbedStream: AsyncStream<String>?

    func startDictation() async throws -> AsyncStream<String> {
        try #require(stubbedStream)
    }

    nonisolated func stopDictation() {}
}
