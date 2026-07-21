//
//  MockTakeRepository.swift
//  Resume
//
//  Created by Ives Murillo on 7/20/26.
//

import Foundation
@testable import Resume

actor MockTakeRepository: TakeRepository {
    private(set) var savedTakes: [Take] = []
    private(set) var deletedIds: [UUID] = []

    func save(_ take: Resume.Take) async throws {
        savedTakes.append(take)
    }

    func delete(id: UUID) async throws {
        deletedIds.append(id)
    }
}
