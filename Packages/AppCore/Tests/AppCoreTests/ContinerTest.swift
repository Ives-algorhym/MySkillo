//
//  File.swift
//  AppCore
//
//  Created by Ives Murillo on 3/5/26.
//

import Testing
@testable import AppCore

@Suite("AppContiner")
struct AppContinerTests {
    @Test("register + resolve returns instance")
    func registerAndResolve() throws {
        let continer = Continer()
        continer.register(ServiceA.self) { _ in ServiceA(id: 1) }

        _ = try continer.resolve(ServiceA.self)
    }

    @Test("resolve missing registration throws error")
    func resolveMissingRegistrationThrows() {
        let continer = Continer()

        #expect(throws: ResolutionError.missingRegistration) {
            _ = try continer.resolve(ServiceA.self)
        }
    }

    @Test("register overrides existing factory")
    func registerOverridesExistingFactory() throws {
        let continer = Continer()
        continer.register(ServiceA.self) { _ in ServiceA(id: 1) }
        continer.register(ServiceA.self) { _ in ServiceA(id: 2) }

        let service = try continer.resolve(ServiceA.self)

        #expect(service.id == 2)
    }

    @Test("factory can resolve other dependencies")
    func factoryResolveOtherDependencies() throws {
        let continer = Continer()
        continer.register(ServiceA.self) { _ in ServiceA(id: 1) }
        continer.register(ServiceB.self) { continer in
            let service: ServiceA = try! continer.resolve(ServiceA.self)
            return ServiceB(service: service)
        }

        _ = try continer.resolve(ServiceB.self)
    }
}

@Suite("DependencyRegistering")
struct DependencyRegisteringTests {
    @Test("registrant can register dependencies")
    func registrantCanRegisterDependencies() throws {
        let continer = Continer()

        FeatureA.register(in: continer)

        _ = try continer.resolve(ServiceA.self)
    }
}

@Suite("FeatureRegistry")
struct FeatureRegistryTests {
    @Test("register all calls each registrant")
    func registerAllCallsEachRegistrant() throws {
        let continer = Continer()

        FeatureRegistry(registrants: [FeatureA.self, FeatureB.self])
            .registerAll(in: continer)

        _ = try continer.resolve(ServiceA.self)
        _ = try continer.resolve(ServiceB.self)
    }
}

enum FeatureA: DependnencyRegistering {
    static func register(in continer: Continer) {
        continer.register(ServiceA.self) { _ in ServiceA(id: 1) }
    }
}

enum FeatureB: DependnencyRegistering {
    static func register(in continer: Continer) {
        continer.register(ServiceB.self) { continer in
            let dep: ServiceA = try! continer.resolve(ServiceA.self)
            return ServiceB(service: dep)
        }
    }
}

final class ServiceA {
    let id: Int
    init(id: Int) { self.id = id }
}

final class ServiceB {
    let service: ServiceA
    init(service: ServiceA) { self.service = service }
}
