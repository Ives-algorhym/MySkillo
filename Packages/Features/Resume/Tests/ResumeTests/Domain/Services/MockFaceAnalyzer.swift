//
//  MockFaceAnalyzer.swift
//  Resume
//
//  Created by Ives Murillo on 7/21/26.
//

@testable import Resume
import Testing

/// In-memory test double for `FaceAnalyzer`.
actor MockFaceAnalyzer: FaceAnalyzer {
    /// Number of times `analyze(_:)` has been called.
    private(set) var analyzedCallCount: Int = 0

    /// The result returned by `analyze(_:)`. Must be set before calling.
    var stubbedResult: FaceAnalysis?

    func analyze(_: Take) async throws -> FaceAnalysis {
        analyzedCallCount += 1
        return try #require(stubbedResult)
    }
}
