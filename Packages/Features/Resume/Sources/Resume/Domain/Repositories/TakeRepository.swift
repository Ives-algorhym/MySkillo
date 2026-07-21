//
//  TakeRepository.swift
//  Resume
//
//  Created by Ives Murillo on 7/20/26.
//

import Foundation

protocol TakeRepository {
    func save(_ take: Take) async throws
    func delete(id: UUID) async throws
    func fetch(id: UUID) async throws -> Take
    func fetchAll() async throws -> [Take]
    func setActiveVideoResume(_ takeId: UUID) async throws
    func fetchActiveVideoResume() async throws -> Take?
}
