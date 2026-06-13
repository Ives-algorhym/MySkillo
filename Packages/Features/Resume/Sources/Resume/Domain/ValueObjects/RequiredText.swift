//
//  RequiredText.swift
//  Resume
//
//  Created by Ives Murillo on 6/12/26.
//

struct  RequiredText {
    let value: String

    init?(_ value: String) {
        let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return nil }
        self.value = trimmed
    }
}
