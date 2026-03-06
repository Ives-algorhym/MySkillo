//
//  Environment.swift
//
//
//  Created by Ives Murillo on 3/5/26.
//

public struct Environment: Sendable {
    public let name: String

    public static let production = Environment(name: "production")
    public static let development = Environment(name: "development")
}
