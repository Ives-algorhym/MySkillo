//
//  Coordinate.swift
//  Resume
//
//  Created by Ives Murillo on 6/12/26.
//

/// A validated geographic coordinate with latitude and longitude bounds enforced.
///
/// Initialization fails if `latitude` is outside `[-90, 90]`
/// or `longitude` is outside `[-180, 180]`.
struct Coordinate: Equatable {
    /// Degrees north (positive) or south (negative) of the equator. Range: -90...90.
    let latitude: Double
    /// Degrees east (positive) or west (negative) of the prime meridian. Range: -180...180.
    let longitude: Double

    init?(latitude: Double, longitude: Double) {
        guard latitude <= 90, latitude >= -90, longitude <= 180, longitude >= -180 else {
            return nil
        }
        self.latitude = latitude
        self.longitude = longitude
    }
}
