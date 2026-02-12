# MySkills iOS

A personal “enterprise-style” iOS app to showcase real-world engineering skills:
- Modular architecture (SPM-first)
- Clean Architecture boundaries
- TDD-first development
- Two app shells: **UIKit** and **SwiftUI**
- Designed to scale as if a team will join later

## Goals

- Build features as independent modules (SPM packages).
- Keep app targets thin (composition + navigation only).
- Use CI from day one (GitHub Actions).
- Track work with GitHub Issues + Projects.
- Write documentation like a real team (ADRs, architecture notes).

## Tech & Practices

- **UI:** UIKit + SwiftUI (two separate app targets)
- **Modules:** Swift Package Manager (SPM)
- **Testing:** XCTest and/or Swift Testing (project choice per module)
- **CI/CD:** GitHub Actions
- **Quality:** SwiftFormat (and optionally SwiftLint)
- **Architecture:** Clean Architecture + MVVM (and Coordinator/Router where needed)

## Repository Structure

myskills-ios/
├── MySkills.xcworkspace/
├── Apps/
│   ├── MySkillsUIKitApp/        # UIKit executable
│   └── MySkillsSwiftUIApp/      # SwiftUI executable
├── Packages/
│   ├── CoreKit/                 # networking, logging, shared utilities
│   ├── DesignSystem/            # tokens + UIKit/SwiftUI components
│   └── Features/                # feature modules (Home, Profile, etc.)
└── Docs/
├── architecture.md
└── adr/             


## ROAD MAP
v0.1 — Ship the simplest working app (Resume Landing)
	•	Workspace + two app shells
	•	MySkillsUIKitApp (UIKit)
	•	MySkillsSwiftUIApp (SwiftUI)
	•	Composition Root (minimal, scalable)
	•	App entry + environment wiring (dependency container)
	•	Feature registration / assembly pattern (so adding features stays clean)
	•	Routing contract (UIKit Coordinator / SwiftUI Router) — minimal
	•	PlatformKit (reusable for any app)
	•	Logging (simple protocol + default console implementation)
	•	Analytics (protocol + “Noop” implementation by default)
	•	Networking (HTTPClient protocol + URLSession implementation)
	•	MyResumeFeature
	•	Static resume model (local JSON or hardcoded model to start)
	•	Landing screen UI in UIKit
	•	Landing screen UI in SwiftUI
	•	Basic tests for:
	•	Resume model mapping
	•	ViewModel state (if you use MVVM)
	•	CI baseline
	•	Build + test on PR (GitHub Actions)
	•	Protect main (PR required + checks required)

