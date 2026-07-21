//
//  TakeTests.swift
//  Resume
//
//  Created by Ives Murillo on 6/1/26.
//

import Foundation
@testable import Resume
import Testing

@Suite("Take Tests")
struct TakeTests {
    @Suite("isAnalyzable Tests")
    struct IsAnalyzableTests {
        @Test func whenStatusIsDiscarded_returnsFalse() {
            // Arrange
            let sut = Take.make(status: .discarded)
            // Act
            let result = sut.isAnalyzable
            // Assert
            #expect(result == false)
        }

        @Test func whenStatusIsRecorded_returnsTrue() {
            // Arrange
            let sut = Take.make(status: .recorded)
            // Act
            let result = sut.isAnalyzable
            // Assert
            #expect(result == true)
        }

        @Test func whenStatusIsAnalyzed_returnsFalse() throws {
            // Arrange
            let report = try #require(CoachingReportFactory.make())
            let sut = Take.make(status: .analyzed(report))
            // Act
            let result = sut.isAnalyzable
            // Assert
            #expect(result == false)
        }

        @Test func whenStatusIsAnalyzing_returnsFalse() {
            // Arrange
            let sut = Take.make(status: .analyzing)
            // Act
            let result = sut.isAnalyzable
            // Assert
            #expect(result == false)
        }

        @Test func whenStatusIsFailed_returnsFalse() {
            // Arrange
            let sut = Take.make(status: .failed(TakeError.unknown))
            // Act
            let result = sut.isAnalyzable
            // Assert
            #expect(result == false)
        }
    }

    @Suite("Is Promotable test")
    struct IsPromotableTests {
        @Test func whenStatusIsAnalyzed_returnsTrue() throws {
            // Arrange
            let report = try #require(CoachingReportFactory.make())
            let sut = Take.make(status: .analyzed(report))
            // Act
            let result = sut.isPromotable
            // Assert
            #expect(result == true)
        }

        @Test func whenStatusIsRecorded_returnsFalse() {
            // Arrange
            let sut = Take.make(status: .recorded)
            // Act
            let result = sut.isPromotable
            // Assert
            #expect(result == false)
        }

        @Test func whenStatusIsAnalyzing_returnsFalse() {
            // Arrange
            let sut = Take.make(status: .analyzing)
            // Act
            let result = sut.isPromotable
            // Assert
            #expect(result == false)
        }

        @Test func whenStatusIsFailed_returnsFalse() {
            // Arrange
            let sut = Take.make(status: .failed(TakeError.unknown))
            // Act
            let result = sut.isPromotable
            // Assert
            #expect(result == false)
        }
    }

    @Suite("TakeStatus tests")
    struct TakeStatusTests {
        @Test
        func analyzedStatus_storesCoachingReport() throws {
            // Arrange
            let report = try #require(CoachingReportFactory.make())
            // Act
            let sut = TakeStatus.analyzed(report)

            guard case let .analyzed(storedReport) = sut else {
                Issue.record("Expected analyzed status")
                return
            }
            // Assert
            #expect(storedReport == report)
        }

        @Test
        func faliledStatus_storesTakeError() {
            // Arrange
            let error = TakeError.unknown
            // Act
            let sut = TakeStatus.failed(error)
            // Assert
            guard case let .failed(storederror) = sut else {
                Issue.record("Expected failed status")
                return
            }
            #expect(storederror == error)
        }
    }

    @Suite("Take Entity Tests")
    struct TakeEntityTests {
        @Test
        func storesAllRequiredProperties() {
            // Arrange
            let id = UUID()
            let userIdentity = "user-1"
            let fileURL = URL(fileURLWithPath: "/tmp/take.m4a")
            let duration: TimeInterval = 45
            let recordedAt = Date()

            // Act
            let sut = Take(
                id: id,
                userIdentity: userIdentity,
                fileURL: fileURL,
                duration: duration,
                recordedAt: recordedAt,
                status: .recorded
            )
            // Assert
            #expect(sut.id == id)
            #expect(sut.userIdentity == userIdentity)
            #expect(sut.fileURL == fileURL)
            #expect(sut.duration == duration)
            #expect(sut.recordedAt == recordedAt)
        }
    }
}

extension Take {
    static func make(status: TakeStatus) -> Self {
        Self(
            id: UUID(),
            userIdentity: "user-1",
            fileURL: URL(fileURLWithPath: "/tmp/file.m4a"),
            duration: 30,
            recordedAt: Date(),
            status: status
        )
    }
}
