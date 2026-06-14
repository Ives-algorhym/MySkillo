//
//  UserIdentityTests.swift
//  Resume
//
//  Created by Ives Murillo on 6/14/26.
//

import Foundation
import Testing
@testable import Resume

@Suite("UserIdentity")
struct UserIdentityTests {

    @Test func hasCorrectProperties() throws {
        // Arrange
        let id = UUID()
        let name = try #require(RequiredText("John Smith"))
        let title = try #require(RequiredText("iOS Engineer"))
        let coordinate = try #require(
            Coordinate(latitude: 37.36, longitude: -122.03)
        )
        let location = VerifiedLocation(
            displayName: try #require(RequiredText("Sunnyvale, CA")),
            coordinate: coordinate
        )
        let createdAt = Date()

        // Act
        let sut = UserIdentity(
            id: id,
            name: name,
            title: title,
            location: location,
            createdAt: createdAt
        )

        // Assert
        #expect(sut.id == id)
        #expect(sut.name == name)
        #expect(sut.title == title)
        #expect(sut.location == location)
        #expect(sut.createdAt == createdAt)
    }
}
