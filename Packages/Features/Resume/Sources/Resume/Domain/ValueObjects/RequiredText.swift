//
//  RequiredText.swift
//  Resume
//
//  Created by Ives Murillo on 6/12/26.
//

/// A non-empty, whitespace-trimmed string value object.
///
/// Initialization fails if the input is empty or contains only whitespace.
/// The stored `value` is always trimmed.
struct RequiredText: Equatable {
    /// The trimmed, non-empty string.
    let value: String

    init?(_ value: String) {
        let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return nil }
        self.value = trimmed
    }
}
