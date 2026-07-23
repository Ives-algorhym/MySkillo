//
//  PacingAnalizer.swift
//  Resume
//
//  Created by Ives Murillo on 7/22/26.
//

/// Evaluates the pacing quality of a recorded take's transcript.
protocol PacingAnalyzer {
    /// Derives a pacing dimension score from the given transcript analysis.
    func analyze(_ transcript: TranscriptAnalysis) throws -> DimensionScore
}
