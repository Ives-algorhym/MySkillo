//
//  EnviromentTests.swift
//  AppCore
//
//  Created by Ives Murillo on 3/5/26.
//

@testable import AppCore
import Testing

struct EnvirommentTests {
    @Test("enviroment exposes configuration variants")
    func enviromentExposesVariants() {
        let prod = Environment.production
        let dev = Environment.development

        #expect(prod.name == "production")
        #expect(dev.name == "development")
    }
}
