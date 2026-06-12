//
//  MySkilloSwiftUIApp.swift
//  MySkilloSwiftUI
//
//  Created by Ives Murillo on 3/5/26.
//

import AppCore
import SwiftUI

@main
struct MySkilloSwiftUIApp: App {
    let root: CompositionRoot

    init() {
        #if DEBUG
        let environment = Environment.development
        #else
        let environment = Environment.production
        #endif
        root = CompositionRoot(
            environment: environment,
            registry: .init(registrants: [])
        )
    }

    var body: some Scene {
        WindowGroup {
            AnyView(root.makeSwiftUIRoot())
        }
    }
}
