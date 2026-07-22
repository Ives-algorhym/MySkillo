//
//  FaceAnalysis.swift
//  Resume
//
//  Created by Ives Murillo on 7/21/26.
//

/// The result of analysing facial cues captured during a recorded take.
struct FaceAnalysis: Equatable {
    /// Score representing the level of eye contact maintained during the take.
    let eyeContact: InterviewScore

    /// Score representing the quality of facial expressions during the take.
    let expressionScore: InterviewScore

    /// Score representing head stability and movement during the take.
    let headMovementScore: InterviewScore
}
