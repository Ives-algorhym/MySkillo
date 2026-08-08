//
//  TakeStatus.swift
//  Resume
//
//  Created by Ives Murillo on 6/6/26.
//

/// The lifecycle state of a `Take`.
enum TakeStatus {
    /// The take was discarded by the user before it could be processed.
    case discarded
    /// The video has been recorded and is awaiting analysis.
    case recorded
    /// Analysis completed successfully and produced a coaching report.
    case analyzed(CoachingReport)
    /// Analysis or processing failed with an error.
    case failed(TakeError)
    /// Analysis is currently in progress.
    case analyzing
}
