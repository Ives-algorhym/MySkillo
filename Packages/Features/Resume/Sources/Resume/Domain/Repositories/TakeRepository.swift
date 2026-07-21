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
}
