//
//  ResumeRegister.swift
//  AppCore
//
//  Created by Ives Murillo on 3/11/26.
//

import FeatureContracts
import Resume

@available(iOS 13.0, *)
public enum ResumeRegister: DependencyRegistering {
    @MainActor
    public static func register(in container: Container) {
        container.register(ResumeFeatureProviding.self) { _ in
            ResumeFeature()
        }
    }
}
