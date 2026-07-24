//
//  LocationVerificationService.swift
//  Resume
//
//  Created by Ives Murillo on 7/23/26.
//

/// Validates a raw location string and returns a typed, verified location.
protocol LocationVerificationService {
    /// Parses and verifies `input`, throwing if the location cannot be resolved.
    func verify(_ input: String) async throws -> VerifiedLocation
}
