//
//  UserIdentity.swift
//  Resume
//
//  Created by Ives Murillo on 6/14/26.
//

import Foundation

/// The identity profile of a user participating in the resume feature.
///
/// `UserIdentity` captures who the user is and where they are located
/// at the time their profile is created. It is immutable by design —
/// changes produce a new instance.
struct UserIdentity: Equatable {
    /// Stable identifier for this user.
    let id: UUID
    /// The user's display name.
    let name: RequiredText
    /// The user's professional title (e.g. "Software Engineer").
    let title: RequiredText
    /// The user's verified geographic location.
    let location: VerifiedLocation
    /// When this identity record was created.
    let createdAt: Date
}
