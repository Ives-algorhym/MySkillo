//
//  Take.swift
//  Resume
//
//  Created by Ives Murillo on 6/1/26.
//

import Foundation

/// A single recorded video attempt by a user for analysis and potential promotion.
///
/// A `Take` moves through a lifecycle tracked by `TakeStatus`.
/// Use `isAnalyzable` to check if it's eligible for AI analysis,
/// and `isPromotable` to check if it can be added to the user's resume.
@available(iOS 16.0, *)
struct Take {
    /// Stable identifier for this take.
    let id: UUID
    /// The identity of the user who recorded this take.
    let userIdentity: String
    /// Local file URL pointing to the recorded video.
    let fileURL: URL
    /// Length of the recording in seconds.
    let duration: TimeInterval
    /// When the recording was captured.
    let recordedAt: Date
    /// Current lifecycle state of this take.
    let status: TakeStatus

    /// `true` when the take has been recorded and is ready to be sent for analysis.
    var isAnalyzable: Bool {
        if case .recorded = status {
            return true
        }
        return false
    }

    /// `true` when analysis is complete and the take can be promoted to the resume.
    var isPromotable: Bool {
        if case .analyzed = status {
            return true
        }

        return false
    }
}
