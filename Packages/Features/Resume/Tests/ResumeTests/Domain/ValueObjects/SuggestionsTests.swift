//
//  SuggestionsTests.swift
//  Resume
//
//  Created by Ives Murillo on 7/16/26.
//

@testable import Resume
import Testing

@Suite("Suggestion Test")
struct SuggestionsTests {
    @Suite("Intit Tests")
    struct Initializer {
        @Test("Init")
        func init_hasCorrectProperties() {
            // Arrange
            let dimension: DimensionType = .eyeContact
            let description: RequiredText = .init("keep eye contact")!
            // Act
            let sut = Suggestion(
                dimension: dimension,
                text: description
            )
            // Assert
            #expect(sut.dimension == dimension)
            #expect(sut.text == description)
        }
    }
}

extension Suggestion {
    static let sample = [
        Suggestion(
            dimension: .eyeContact,
            text: .init("keep eye contact")!
        ),
        Suggestion(
            dimension: .fillerWords,
            text: .init("avoid filling words")!
        ),
        Suggestion(
            dimension: .pacing,
            text: .init("pacing too fast")!
        ),
    ]
}
