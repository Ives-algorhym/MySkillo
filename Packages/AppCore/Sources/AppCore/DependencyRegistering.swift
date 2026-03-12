//
//  DependencyRegistering.swift
//  AppCore
//
//  Created by Ives Murillo on 3/5/26.
//

public protocol DependencyRegistering {
    @MainActor
    static func register(in container: Container)
}
