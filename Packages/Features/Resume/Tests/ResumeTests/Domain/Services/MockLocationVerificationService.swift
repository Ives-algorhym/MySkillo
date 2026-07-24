//
//  MockLocationVerificationService.swift
//  Resume
//
//  Created by Ives Murillo on 7/23/26.
//

@testable import Resume
import Testing

/// In-memory test double for `LocationVerificationService`.
actor MockLocationVerificationService: LocationVerificationService {
    /// The result returned by `verify(_:)`. Must be set before calling.
    var stubbedResult: VerifiedLocation?

    func verify(_: String) async throws -> VerifiedLocation {
        try #require(stubbedResult)
    }
}
