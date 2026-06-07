//
//  Take.swift
//  Resume
//
//  Created by Ives Murillo on 6/1/26.
//

import Foundation

@available(iOS 16.0, *)
struct Take {
    let id: UUID
    let userIdentity: String
    let fileURL: URL
    let duration: TimeInterval
    let recordedAt: Date
    let status: TakeStatus

    var isAnalyzable: Bool {
        if case .recorded = status {
            return true
        }
        return false
    }

    var isPromotable: Bool {
        if case .analyzed = status {
            return true
        }

        return false
    }
}
