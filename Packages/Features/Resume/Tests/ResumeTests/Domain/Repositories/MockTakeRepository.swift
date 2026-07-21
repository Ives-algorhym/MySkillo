//
//  MockTakeRepository.swift
//  Resume
//
//  Created by Ives Murillo on 7/20/26.
//

import Foundation
@testable import Resume

/// In-memory test double for `TakeRepository`.
actor MockTakeRepository: TakeRepository {
    /// Takes recorded by `save(_:)` calls, in order.
    private(set) var savedTakes: [Take] = []

    /// IDs recorded by `delete(id:)` calls, in order.
    private(set) var deletedIds: [UUID] = []

    /// The ID last passed to `setActiveVideoResume(_:)`.
    private(set) var activeVideoResumeId: UUID?

    func save(_ take: Take) async throws {
        savedTakes.append(take)
    }

    func delete(id: UUID) async throws {
        deletedIds.append(id)
    }

    func fetch(id: UUID) async throws -> Take {
        guard let take = savedTakes.first(where: { $0.id == id }) else {
            throw TakeError.unknown
        }
        return take
    }

    func fetchAll() async throws -> [Take] {
        savedTakes
    }

    func setActiveVideoResume(_ takeId: UUID) async throws {
        activeVideoResumeId = takeId
    }

    func fetchActiveVideoResume() async throws -> Take? {
        guard let id = activeVideoResumeId else { return nil }
        return savedTakes.first(where: { $0.id == id })
    }
}
