//
//  NLPScorer.swift
//  Resume
//
//  Created by Ives Murillo on 7/22/26.
//

/// Scores a transcript analysis using natural language processing.
protocol NLPScorer {
    /// Derives a dimension score from the given transcript analysis.
    func score(_ transcript: TranscriptAnalysis) throws -> DimensionScore
}
