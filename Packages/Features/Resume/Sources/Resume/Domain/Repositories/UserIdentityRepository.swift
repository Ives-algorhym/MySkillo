//
//  UserIdentityRepository.swift
//  Resume
//
//  Created by Ives Murillo on 7/21/26.
//

/// Defines persistence operations for the current user's identity.
protocol UserIdentityRepository {
    /// Persists the given user identity, replacing any previously stored value.
    func save(_ identity: UserIdentity) async throws

    /// Returns the stored user identity, or `nil` if none has been saved.
    func fetch() async throws -> UserIdentity?
}
