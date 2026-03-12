//
//  ResumeRegisterTests.swift
//  AppCore
//
//  Created by Ives Murillo on 3/11/26.
//

@testable import AppCore
import FeatureContracts
import Testing

struct ResumeRegisterTests {
    @MainActor
    @Test("Resume register register a provider")
    func registersResumeProvider() throws {
        // Arrange
        let container = Container()

        ResumeRegister.register(in: container)

        #expect(throws: Never.self) {
            _ = try container.resolve(ResumeFeatureProviding.self)
        }
    }
}
