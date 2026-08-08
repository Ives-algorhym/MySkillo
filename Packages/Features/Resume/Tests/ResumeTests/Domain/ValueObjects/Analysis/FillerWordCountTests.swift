//
//  FillerWordCountTests.swift
//  Resume
//
//  Created by Ives Murillo on 7/20/26.
//

@testable import Resume
import Testing

@Suite("FillerWords Tests")
struct FillerWordCountTests {
    @Test("Can not be created with negative values")
    func withNegativeValues_fail() {
        #expect(FillerWordCount(-2) == nil)
    }

    @Test("Can be created with zero value")
    func withZeroValue_succeeds() {
        #expect(FillerWordCount(0) != nil)
    }

    @Test("Can be created with valid values")
    func withValidValue_succeeds() {
        #expect(FillerWordCount(4) != nil)
    }
}
