//
//  VideoResumeTests.swift
//  Resume
//
//  Created by Ives Murillo on 7/20/26.
//

import Foundation
@testable import Resume
import Testing

@Suite("Video Resume Tests")
struct VideoResumeTests {
    @Suite("init")
    struct InitTests {
        @available(iOS 16.0, *)
        @Test("Can not be created from a non-promotable Take")
        func whitNonPromotableTake_fail() {
            // Arrange
            let take = Take.make(status: .recorded)
            // Act & Assert
            #expect(VideoResume(from: take) == nil)
        }

        @available(iOS 16.0, *)
        @Test("Can be created from a promotable Take")
        func whitPromotableTake_Succed() throws {
            // Arrange
            let coachingReport = try #require(CoachingReportFactory.make())
            let take = Take.make(status: .analyzed(coachingReport))
            // Act & Assert
            #expect(VideoResume(from: take) != nil)
        }

        @available(iOS 16.0, *)
        @Test("Has correct properties")
        func hasCorrectProperties() throws {
            // Arrange
            let before = Date()
            let coachingReport = try #require(CoachingReportFactory.make())
            let take = Take.make(status: .analyzed(coachingReport))
            // Act
            let sut = try #require(VideoResume(from: take))
            let after = Date()
            // Assert
            #expect(sut.promotedAt >= before)
            #expect(sut.promotedAt <= after)
        }

        @available(iOS 16.0, *)
        @Test("Two video with sawe Take are equal")
        func withSameTakeId_areEqual() throws {
            // Arrange
            let coachingReport = try #require(CoachingReportFactory.make())
            let take = Take.make(status: .analyzed(coachingReport))
            // Act
            let sutA = try #require(VideoResume(from: take))
            let sutB = try #require(VideoResume(from: take))
            // Assert
            #expect(sutA == sutB)
        }
    }
}
