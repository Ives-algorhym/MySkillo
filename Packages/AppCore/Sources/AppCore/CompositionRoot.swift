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

/// The central composition root responsible for assembling and wiring the application's dependency graph.
///
/// `CompositionRoot` serves as the main entry point for dependency injection and application composition.
/// It orchestrates the creation of the dependency injection container, registers all features and their
/// dependencies, and provides factory methods for creating root-level application components for both
/// UIKit and SwiftUI architectures.
///
/// ## Responsibilities
///
/// - **Dependency Container Setup**: Creates and configures the `Container` with all necessary registrations
/// - **Feature Registration**: Delegates feature registration to the `FeatureRegistry`
/// - **Environment Management**: Registers the application's `Environment` configuration
/// - **Root Component Creation**: Provides factory methods for creating root coordinators and views
///
/// ## Architecture
///
/// The composition root follows the Composition Root pattern, centralizing all dependency wiring logic
/// in a single location. This approach ensures that:
/// - Dependencies are resolved at the application's entry point
/// - Feature modules remain decoupled from the dependency injection mechanism
/// - The dependency graph is constructed once and reused throughout the app's lifecycle
///
/// ## Usage
///
/// ```swift
/// // Create the composition root
/// let environment = Environment.production
/// let registry = FeatureRegistry(registrants: [ResumeRegister.self])
/// let compositionRoot = CompositionRoot(environment: environment, registry: registry)
///
/// // For UIKit applications
/// let rootCoordinator = compositionRoot.makeUIKitRoot()
/// rootCoordinator.start()
/// window?.rootViewController = rootCoordinator.rootViewController
///
/// // For SwiftUI applications
/// let rootView = compositionRoot.makeSwiftUIRoot()
/// let hostingController = UIHostingController(rootView: rootView)
/// window?.rootViewController = hostingController
/// ```
///
/// ## Thread Safety
///
/// All public methods are marked with `@MainActor` to ensure they execute on the main thread,
/// which is required for UIKit and SwiftUI component creation.
///
/// - Note: The container is lazily initialized on first access to allow the composition root
///   to be created without immediately triggering the dependency graph construction.
/// - Warning: If container initialization fails due to registration errors, the application
///   will terminate with a fatal error. Ensure all registrants are properly configured.
@available(iOS 13.0, *)
@MainActor
public class CompositionRoot {
    /// The application environment configuration (e.g., production, development).
    private let environment: Environment
    
    /// The registry containing all feature module dependency registrants.
    private let registry: FeatureRegistry

    /// The dependency injection container holding all registered services and dependencies.
    ///
    /// The container is lazily initialized to defer dependency graph construction until
    /// it's actually needed. This allows the composition root to be created early in the
    /// app lifecycle without incurring the cost of resolving all dependencies upfront.
    private(set) lazy var container: Container = makeContainer()

    /// Creates a new composition root with the specified environment and feature registry.
    ///
    /// - Parameters:
    ///   - environment: The application environment configuration
    ///   - registry: The feature registry containing all dependency registrants
    public init(environment: Environment, registry: FeatureRegistry) {
        self.environment = environment
        self.registry = registry
    }

    /// Constructs and configures the dependency injection container.
    ///
    /// This method creates a new `Container` instance and populates it with:
    /// 1. The application's `Environment` configuration
    /// 2. All feature module dependencies via the `FeatureRegistry`
    ///
    /// - Returns: A fully configured `Container` ready for dependency resolution
    /// - Note: This method is called lazily when the `container` property is first accessed
    /// - Warning: If any registration fails, the application will terminate with a fatal error
    private func makeContainer() -> Container {
        let container = Container()
        do {
            try container.register(Environment.self) { _ in
                self.environment
            }

            try registry.registerAll(in: container)
            return container

        } catch {
            fatalError("Failed to build continer")
        }
    }

    /// Creates the root coordinator for UIKit-based applications.
    ///
    /// This factory method resolves the necessary dependencies from the container and
    /// constructs a `RootCoordinator` that manages the app's navigation flow. If the
    /// resume feature provider cannot be resolved, a fallback implementation is used
    /// to ensure the app can still launch.
    ///
    /// - Returns: A configured `RootCoordinating` instance ready to manage the app's UI hierarchy
    /// - Note: Must be called on the main thread due to UIKit requirements
    @MainActor
    public func makeUIKitRoot() -> RootCoordinating {
        let resumeProvider = try? container.resolve(ResumeFeatureProviding.self)
        return RootCoordinator(resumeProvider: resumeProvider ?? FallbackResumeProvider())
    }

    /// Creates the root view for SwiftUI-based applications.
    ///
    /// This factory method constructs the top-level SwiftUI view that serves as the
    /// entry point for the SwiftUI application hierarchy.
    ///
    /// - Returns: The root SwiftUI view
    /// - Note: Must be called on the main thread due to SwiftUI requirements
    @MainActor
    public func makeSwiftUIRoot() -> some View {
        return RootView()
    }

    /// A fallback implementation of `ResumeFeatureProviding` used when the actual provider
    /// cannot be resolved from the container.
    ///
    /// This prevents the application from crashing if feature registration fails, allowing
    /// the app to launch with minimal functionality for debugging purposes.
    private struct FallbackResumeProvider: ResumeFeatureProviding {
        func makeResumeViewController() -> UIViewController {
            UIViewController()
        }
    }
}

/// The root SwiftUI view for the application.
///
/// This view serves as the top-level container for the SwiftUI-based application.
/// Currently displays a placeholder text, but can be extended to include navigation,
/// tab views, or other root-level UI components.
@available(iOS 13.0, *)
struct RootView: View {
    var body: some View {
        Text("My Skillo")
    }
}
