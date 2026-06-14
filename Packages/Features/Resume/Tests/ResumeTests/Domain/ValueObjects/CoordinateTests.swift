//
//  CoordinateTests.swift
//  Resume
//
//  Created by Ives Murillo on 6/12/26.
//

import Testing
@testable import Resume

@Suite("Coordinate Tests")
struct CoordinateTests {

    @Suite("Latitude Init")
    struct LatitudeInitTests {

        @Test
        func whenLatitudeAbove90_returnsNil() {
            #expect(Coordinate(latitude: 91, longitude: 0) == nil)
        }

        @Test
        func whenLatitudeBelowNegative90_returnsNil() {
            #expect(Coordinate(latitude: -91, longitude: 0) == nil)
        }

        @Test
        func whenLatitudeIsValid_returnsInstance() {
            #expect(Coordinate(latitude: 45, longitude: 0) != nil)
        }
    }

    @Suite("Longitude Init")
    struct LongitudeInitTests {

        @Test
        func whenLongitudeAbove180_returnsNil() {
            #expect(Coordinate(latitude: 45, longitude: 181) == nil)
        }

        @Test
        func whenLongitudeeBelowNegative180_returnsNil() {
            #expect(Coordinate(latitude: 0, longitude: -181) == nil)
        }

        @Test
        func whenLongitudeIsValid_returnsInstance() {
            #expect(Coordinate(latitude: 0, longitude: 160) != nil)
        }
    }
}
