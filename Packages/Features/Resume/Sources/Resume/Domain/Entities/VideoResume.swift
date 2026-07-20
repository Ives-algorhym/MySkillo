//
//  VideoResume.swift
//  Resume
//
//  Created by Ives Murillo on 7/20/26.
//

import Foundation

@available(iOS 16.0, *)
struct VideoResume: Equatable {
    let takeId: UUID
    let promotedAt: Date

    init?(from take: Take) {
        guard take.isPromotable else { return nil }
        takeId = take.id
        promotedAt = Date()
    }

    static func == (lhs: VideoResume, rhs: VideoResume) -> Bool {
        lhs.takeId == rhs.takeId
    }
}
