//
//  FaceAnalyzer.swift
//  Resume
//
//  Created by Ives Murillo on 7/21/26.
//

/// Analyses the facial cues captured in a recorded take.
protocol FaceAnalyzer {
    /// Processes the given take and returns a structured face analysis result.
    func analyze(_ take: Take) async throws -> FaceAnalysis
}
