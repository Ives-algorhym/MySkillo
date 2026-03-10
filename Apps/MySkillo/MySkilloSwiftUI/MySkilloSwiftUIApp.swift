//
//  MySkilloSwiftUIApp.swift
//  MySkilloSwiftUI
//
//  Created by Ives Murillo on 3/5/26.
//

import SwiftUI
import AppCore

@main
struct MySkilloSwiftUIApp: App {

    let root = CompositionRoot(environment: .development,
                          registry: .init(registrants: [])
    )



    var body: some Scene {
        WindowGroup {
            AnyView(root.makeSwiftUIRoot())
        }
    }
}
