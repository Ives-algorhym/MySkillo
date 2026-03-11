//
//  CompositionRoot.swift
//  AppCore
//
//  Created by Ives Murillo on 3/6/26.
//

import FeatureContracts
import Foundation
import SwiftUI
import UIKit

@available(iOS 13.0, *)
@MainActor
public class CompositionRoot {
    private let environment: Environment
    private let registry: FeatureRegistry

    private(set) lazy var container: Container = {
        let container = Container()

        container.register(Environment.self) { _ in
            self.environment
        }

        registry.registerAll(in: container)
        return container
    }()

    public init(environment: Environment, registry: FeatureRegistry) {
        self.environment = environment
        self.registry = registry
    }

    @MainActor
    public func makeUIKitRoot() -> RootCoordinating {

        let resumeProvider = try? container.resolve(ResumeFeatureProviding.self)
        return RootCoordinator(resumeProvider: resumeProvider ?? FallbackResumeProvider())
    }

    @MainActor
    public func makeSwiftUIRoot() -> some View {
        return RootView()
    }

    private struct FallbackResumeProvider: ResumeFeatureProviding {
        func makeResumeViewController() -> UIViewController {
            UIViewController()
        }
    }
}

@available(iOS 13.0, *)
struct RootView: View {
    var body: some View {
        Text("My Skillo")
    }
}
