//
//  File.swift
//  AppCore
//
//  Created by Ives Murillo on 3/5/26.
//

import Testing
@testable import AppCore

@Suite("App Enviroment")
struct EnvirommentTests {
    @Test("enviroment exposes configuration variants")
    func enviromentExposesVariants() async throws {

        let prod = Environment.production
        let dev = Environment.development

        #expect(prod.name == "production")
        #expect(dev.name == "development")
    }
}


