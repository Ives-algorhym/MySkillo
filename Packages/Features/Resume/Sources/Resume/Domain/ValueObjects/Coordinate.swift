//
//  Coordinate.swift
//  Resume
//
//  Created by Ives Murillo on 6/12/26.
//

struct Coordinate: Equatable {
    let latitude: Double
    let longitude: Double

    init?(latitude: Double, longitude: Double) {
        guard latitude <= 90, latitude >= -90, longitude <= 180, longitude >= -180 else {
            return nil
        }
        self.latitude = latitude
        self.longitude = longitude
    }
}
