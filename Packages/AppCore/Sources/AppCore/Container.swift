//
//  Container.swift
//  AppCore
//
//  Created by Ives Murillo on 3/5/26.
//

import Foundation

public final class Container {
    private var factories: [ObjectIdentifier: (Container) -> Any] = [:]

    public init() {}

    func register<T>(_ type: T.Type, factory: @escaping (Container) -> T) {
        factories[ObjectIdentifier(type)] = { container in
            factory(container)
        }
    }

    func resolve<T>(_ type: T.Type) throws -> T {
        guard let factory = factories[ObjectIdentifier(type)] else {
            throw ResolutionError.missingRegistration
        }

        return factory(self) as! T
    }
}

enum ResolutionError: Error {
    case missingRegistration
}
