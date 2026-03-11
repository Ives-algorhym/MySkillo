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
    let root = CompositionRoot(
        environment: .development,
        registry: .init(registrants: [])
    )

    var body: some Scene {
        WindowGroup {
            AnyView(root.makeSwiftUIRoot())
        }
    }
}
