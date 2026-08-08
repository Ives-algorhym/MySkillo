//
//  TranscriptAnalysis.swift
//  Resume
//
//  Created by Ives Murillo on 7/21/26.
//

/// The result of analysing a recorded take's spoken content.
struct TranscriptAnalysis: Equatable {
    /// The full text of the spoken content.
    let transcript: String

    /// Speaking speed measured in words per minute.
    let wordsPerMinute: WordsPerMinute

    /// Number of filler words detected in the transcript.
    let fillerWordCount: FillerWordCount

    /// Domain-relevant keywords identified in the transcript.
    let keyWords: [String]
}
