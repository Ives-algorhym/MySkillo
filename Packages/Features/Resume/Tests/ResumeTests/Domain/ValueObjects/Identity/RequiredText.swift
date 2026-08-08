//
//  RequiredText.swift
//  Resume
//
//  Created by Ives Murillo on 6/12/26.
//

@testable import Resume
import Testing

@Suite("RequiredText Tests")
struct RequiredTextTests {
    @Suite("Init")
    struct InitTests {
        @Test
        func whenEmptyString_returnsNil() {
            #expect(RequiredText("") == nil)
        }

        @Test
        func whenWhiteSpaceOnly_returnNil() {
            #expect(RequiredText("  ") == nil)
        }

        @Test
        func whenLeadingAndTrailingWhiteSpace_trimsAndRetunrsValue() {
            // Arrange
            let sut = RequiredText(" iOS Engineer  ")
            // Act - Assert
            #expect(sut?.value == "iOS Engineer")
        }

        @Test
        func whenValidString_returnsValue() {
            #expect(RequiredText("iOS Engineer") != nil)
        }
    }
}
