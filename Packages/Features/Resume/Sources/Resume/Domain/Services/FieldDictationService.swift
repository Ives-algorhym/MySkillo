//
//  FieldDictationService.swift
//  Resume
//
//  Created by Ives Murillo on 7/22/26.
//

/// Streams real-time speech-to-text output for a single dictation session.
protocol FieldDictationService {
    /// Begins a dictation session and returns a stream of recognized text fragments.
    func startDictation() async throws -> AsyncStream<String>

    /// Stops the active dictation session and closes the stream.
    func stopDictation()
}
