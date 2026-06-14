//
//  VerifiedLocationTests.swift
//  Resume
//
//  Created by Ives Murillo on 6/13/26.
//

import Testing
@testable import Resume

@Suite("VerifiedLocation")
struct VerifiedLocationTests {

    @Test
    func whenValidInputs_hasCorrectProperties() throws {
        // Arrange
        let name = try #require(RequiredText("San Francisco, CA"))
        let coordinate = try #require(Coordinate(latitude: 37.77, longitude: -122.41))

        // Act
        let sut = VerifiedLocation(displayName: name, coordinate: coordinate)
        //Assert
        #expect(sut.displayName == name)
        #expect(sut.coordinate == coordinate)
    }
}
