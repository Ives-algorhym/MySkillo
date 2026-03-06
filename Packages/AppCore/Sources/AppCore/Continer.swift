//
//  File.swift
//  AppCore
//
//  Created by Ives Murillo on 3/5/26.
//

import Foundation

public final class Continer {

    private var factories: [ObjectIdentifier: (Continer) -> Any] = [:]

    public init() {}

    func register<T>(_ type: T.Type, factory: @escaping(Continer) -> T) {
        factories[ObjectIdentifier(type)] = { continer in
            factory(continer)
        }
    }

    func resolve<T>(_ type: T.Type ) throws -> T {
        guard let factory = factories[ObjectIdentifier(type)] else {
            throw ResolutionError.missingRegistration
        }

        return factory(self) as! T
    }
}

enum ResolutionError: Error {
    case missingRegistration
}
