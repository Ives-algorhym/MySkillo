//
//  VerifiedLocation.swift
//  Resume
//
//  Created by Ives Murillo on 6/13/26.
//

/// A geographic location that has been verified with both a human-readable name and coordinates.
struct VerifiedLocation: Equatable {
    /// The display name shown in the UI (e.g. "San Francisco, CA").
    let displayName: RequiredText
    /// The precise geographic coordinates of the location.
    let coordinate: Coordinate
}
