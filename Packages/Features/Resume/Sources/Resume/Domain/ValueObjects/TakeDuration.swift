//
//  TakeDuration.swift
//  Resume
//
//  Created by Ives Murillo on 7/20/26.
//

struct TakeDuration: Equatable {
    let duration: Int

    init?(_ duration: Int) {
        guard duration > 0, duration < 91 else { return nil }
        self.duration = duration
    }

    var isRecommendedRange: Bool {
        duration >= 60
    }
}
