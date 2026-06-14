//
//  UserIdentity.swift
//  Resume
//
//  Created by Ives Murillo on 6/14/26.
//

import Foundation

struct UserIdentity: Equatable {
    let id: UUID
    let name: RequiredText
    let title: RequiredText
    let location: VerifiedLocation
    let createdAt: Date
}
