//
//  PacingAssessmentTests.swift
//  Resume
//
//  Created by Ives Murillo on 7/20/26.
//

@testable import Resume
import Testing

@Suite("PacingAssessment Tests")
struct PacingAssessmentTests {

    @Test("Has all required cases")
    func hasAllCases() {
        // Arrange
        let cases: [PacingAssessment] = [
            .tooSlow,
            .slightlyBelowIdeal,
            .ideal,
            .slightlyAboveIdeal,
            .tooFast
        ]
        // Act & Assert
        #expect(cases.count == 5)
    }
}
