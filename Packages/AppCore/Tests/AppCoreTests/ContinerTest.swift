// swiftlint:disable force_try force_cast
//
//  ContinerTest.swift
//  AppCore
//
//  Created by Ives Murillo on 3/5/26.
//

@testable import AppCore
import Testing

struct AppcontainerTests {
    @Test("register + resolve returns instance")
    func registerAndResolve() throws {
        let container = Container()
        container.register(ServiceA.self) { _ in ServiceA(id: 1) }

        _ = try container.resolve(ServiceA.self)
    }

    @Test("resolve missing registration throws error")
    func resolveMissingRegistrationThrows() {
        let container = Container()

        #expect(throws: ResolutionError.missingRegistration) {
            _ = try container.resolve(ServiceA.self)
        }
    }

    @Test("register overrides existing factory")
    func registerOverridesExistingFactory() throws {
        let container = Container()
        container.register(ServiceA.self) { _ in ServiceA(id: 1) }
        container.register(ServiceA.self) { _ in ServiceA(id: 2) }

        let service = try container.resolve(ServiceA.self)

        #expect(service.id == 2)
    }

    @Test("factory can resolve other dependencies")
    func factoryResolveOtherDependencies() throws {
        let container = Container()
        container.register(ServiceA.self) { _ in ServiceA(id: 1) }
        container.register(ServiceB.self) { container in
            let service: ServiceA = try! container.resolve(ServiceA.self)
            return ServiceB(service: service)
        }

        _ = try container.resolve(ServiceB.self)
    }
}

struct DependencyRegisteringTests {
    @Test("registrant can register dependencies")
    func registrantCanRegisterDependencies() throws {
        let container = Container()

        FeatureA.register(in: container)

        _ = try container.resolve(ServiceA.self)
    }
}

struct FeatureRegistryTests {
    @Test("register all calls each registrant")
    func registerAllCallsEachRegistrant() throws {
        let container = Container()

        FeatureRegistry(registrants: [FeatureA.self, FeatureB.self])
            .registerAll(in: container)

        _ = try container.resolve(ServiceA.self)
        _ = try container.resolve(ServiceB.self)
    }
}

enum FeatureA: DependencyRegistering {
    static func register(in container: Container) {
        container.register(ServiceA.self) { _ in ServiceA(id: 1) }
    }
}

enum FeatureB: DependencyRegistering {
    static func register(in container: Container) {
        container.register(ServiceB.self) { container in
            let dep: ServiceA = try! container.resolve(ServiceA.self)
            return ServiceB(service: dep)
        }
    }
}

final class ServiceA {
    let id: Int
    init(id: Int) {
        self.id = id
    }
}

final class ServiceB {
    let service: ServiceA
    init(service: ServiceA) {
        self.service = service
    }
}

// swiftlint:enable force_try force_cast
