//
//  MockUserIdentityRepository.swift
//  Resume
//
//  Created by Ives Murillo on 7/21/26.
//

@testable import Resume

/// In-memory test double for `UserIdentityRepository`.
actor MockUserIdentityRepository: UserIdentityRepository {
    /// The last identity passed to `save(_:)`.
    private(set) var savedUserIdentity: UserIdentity?

    /// Number of times `save(_:)` has been called.
    private(set) var saveCallCount: Int = 0

    func save(_ identity: UserIdentity) async throws {
        savedUserIdentity = identity
        saveCallCount += 1
    }

    func fetch() async throws -> UserIdentity? {
        savedUserIdentity
    }
}
