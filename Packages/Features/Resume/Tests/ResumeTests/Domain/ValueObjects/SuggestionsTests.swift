//
//  File.swift
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
                description: description
            )
            // Assert
            #expect(sut.dimension == dimension)
            #expect(sut.description == description)
        }
    }
}
