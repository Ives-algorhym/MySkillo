//
//  InterviewScoreTests.swift
//  Resume
//
//  Created by Ives Murillo on 6/30/26.
//

@testable import Resume
import Testing

@Suite("InterviewScore")
struct InterviewScoreTests {
    @Suite("init")
    struct InitTests {
        @Test
        func whenAbove100_returnsNil() {
            #expect(InterviewScore(101) == nil)
        }

        @Test
        func whenBelow0_returnsNil() {
            #expect(InterviewScore(-1) == nil)
        }

        @Test
        func whenValidScore_returnInstance() {
            #expect(InterviewScore(40) != nil)
        }
    }
}
