//
//  InterviewScore.swift
//  Resume
//
//  Created by Ives Murillo on 6/30/26.
//

struct InterviewScore: Codable, Equatable {
    let score: Int

    init?(_ score: Int) {
        guard score >= 0, score <= 100 else { return nil }
        self.score = score
    }
}
