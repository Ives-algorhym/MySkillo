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
