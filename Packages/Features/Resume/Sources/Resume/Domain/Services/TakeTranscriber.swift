//
//  TakeTranscriber.swift
//  Resume
//
//  Created by Ives Murillo on 7/21/26.
//

/// Converts a recorded take into a structured transcript analysis.
protocol TakeTranscriber {
    /// Transcribes the audio content of the given take and returns the analysis result.
    func transcribe(_ take: Take) async throws -> TranscriptAnalysis
}
