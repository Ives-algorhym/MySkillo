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



# Contributing

## Git Workflow Conventions

To keep the repository consistent and professional, follow the conventions below for branches, commits, and pull requests.

---

## Branch Naming

Use this format:

`<type>/<issue-number>-<short-kebab-description>`

### Allowed branch types

- `feature` — new user-facing functionality
- `fix` — bug fixes
- `chore` — maintenance or setup work
- `refactor` — internal code improvements without changing behavior
- `test` — test-only changes
- `docs` — documentation updates
- `ci` — CI/CD pipeline changes
- `spike` — research or temporary exploration work

### Examples

- `feature/9-root-navigation-structure`
- `feature/10-resume-feature-module`
- `refactor/11-feature-entry-pattern`
- `test/12-resume-feature-tests`
- `docs/13-architecture-overview`
- `ci/14-build-and-test-workflow`

### Guidelines

- Keep names short and readable
- Use lowercase letters only
- Use hyphens between words
- Include the related GitHub issue number when possible

---

## Commit Message Convention

Use this format:

`type(scope): short message`

### Common commit types

- `feat`
- `fix`
- `refactor`
- `test`
- `docs`
- `chore`
- `ci`

### Examples

- `feat(app): add root tab bar structure`
- `feat(resume): create resume feature module`
- `refactor(core): extract feature entry contract`
- `test(resume): add resume model tests`
- `docs(architecture): add app structure overview`
- `ci(github): add build and test workflow`

### Guidelines

- Write commits in present tense
- Keep each commit focused on one logical change
- Make the message specific
- Avoid vague messages like `update`, `fix stuff`, or `changes`

---

## Pull Request Title Convention

Use this format:

`[Issue-Number] Type: Short description`

### Examples

- `[9] Feature: Setup root navigation structure`
- `[10] Feature: Create ResumeFeature module`
- `[11] Refactor: Define feature entry pattern`
- `[12] Test: Add baseline ResumeFeature tests`
- `[13] Docs: Add architecture overview`

---

## Pull Request Description Template

Use this template for every PR:

```md
## Summary
Briefly describe what this PR changes.

## Why
Explain why this change is needed.

## Changes
- Added ...
- Updated ...
- Removed ...

## Testing
- [ ] Unit tests pass
- [ ] App builds successfully
- [ ] Verified manually in simulator

## Notes
Anything reviewers should know.
