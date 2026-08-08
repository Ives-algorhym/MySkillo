//
//  TakeRepository.swift
//  Resume
//
//  Created by Ives Murillo on 7/20/26.
//

import Foundation

/// Defines persistence operations for `Take` entities.
protocol TakeRepository {
    /// Persists a new or updated take.
    func save(_ take: Take) async throws

    /// Removes the take with the given identifier.
    func delete(id: UUID) async throws

    /// Returns the take matching the given identifier.
    func fetch(id: UUID) async throws -> Take

    /// Returns all stored takes.
    func fetchAll() async throws -> [Take]

    /// Marks the take with the given identifier as the active video resume.
    func setActiveVideoResume(_ takeId: UUID) async throws

    /// Returns the take currently marked as the active video resume, or `nil` if none is set.
    func fetchActiveVideoResume() async throws -> Take?
}
