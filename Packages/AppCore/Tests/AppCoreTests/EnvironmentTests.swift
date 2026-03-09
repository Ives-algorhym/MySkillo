//
//  EnvironmentTests.swift
//  AppCore
//
//  Created by Ives Murillo on 3/5/26.
//

@testable import AppCore
import Testing

struct EnvironmentTests {
    @Test("environment exposes all supported configuration variants")
    func environmentExposesVariants() {
        let prod = Environment.production
        let dev = Environment.development

        #expect(prod.name == "production")
        #expect(dev.name == "development")
    }
}
