//
//  TranscriptAnalysisTests.swift
//  Resume
//
//  Created by Ives Murillo on 7/21/26.
//

@testable import Resume
import Testing

@Suite("TranscriptAnalysis Tests")
struct TranscriptAnalisysTests {
    @Test("Has correct properties")
    func hasCorrectProperties() throws {
        // Arrange & Act
        let wordsPerMinute = try #require(WordsPerMinute(145))
        let fillerWordCount = try #require(FillerWordCount(2))
        let sut = TranscriptAnalysis(
            transcript: "I build a modular architecture",
            wordsPerMinute: wordsPerMinute,
            fillerWordCount: fillerWordCount,
            keyWords: []
        )

        // Assert
        #expect(sut.transcript == "I build a modular architecture")
        #expect(sut.wordsPerMinute == wordsPerMinute)
        #expect(sut.fillerWordCount == fillerWordCount)
        #expect(sut.keyWords.isEmpty)
    }
}
