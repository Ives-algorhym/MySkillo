# MySkillo

> An iOS engineer's interview coaching app — built by an iOS engineer, for iOS engineers.

![Swift](https://img.shields.io/badge/Swift-5.9-orange?style=flat-square&logo=swift)
![iOS](https://img.shields.io/badge/iOS-17%2B-blue?style=flat-square&logo=apple)
![Architecture](https://img.shields.io/badge/Architecture-Clean%20%2B%20MVVM%20%2B%20Coordinator-purple?style=flat-square)
![TDD](https://img.shields.io/badge/Testing-TDD%20%2B%20BDD%20%2B%20Swift%20Testing-green?style=flat-square)
![Status](https://img.shields.io/badge/Status-In%20Active%20Development-yellow?style=flat-square)

---

> [!NOTE]
> 🔗 All documentation links (Discussions, Wiki, PRD, Issues) are being actively set up.
> Check back shortly — architecture decisions, BDD scenarios, and feature specs will be linked here as they are published.

## What is MySkillo

iOS engineers consistently underperform on behavioral interview questions — not from lack of experience, but from lack of structured, iOS-specific practice. MySkillo lets engineers record a coached "Tell me about yourself" answer, then receive on-device AI feedback calibrated to what iOS hiring managers actually evaluate. All ML inference runs on-device via Core ML — no audio or video ever leaves the device.

---

## Why this project exists

This is not a portfolio to-do app. It is a deliberate attempt to build a production-quality iOS feature from first principles — starting with domain language, bounded contexts, and type-driven design before writing a single line of production code.

Every decision in this project is documented, justified, and traceable — from the GitHub Discussion where the architecture was debated, to the BDD scenario that drove the failing test, to the Swift type that makes the illegal state unrepresentable.

The goal: demonstrate that I think like a senior engineer before I write like one.

---

## Architecture

### Package structure

```
MySkillo (UIKit app host)
│
├── Platform/
│   ├── PlatformContracts      ← feature-facing platform abstractions
│   └── Logging                ← structured logging infrastructure
│
├── FeatureSupport/
│   └── FeatureContracts       ← boundary contracts (app ↔ features)
│
├── Features/
│   └── Resume                 ← video resume feature (v1)
│       ├── Domain/            ← zero framework imports
│       ├── Application/       ← use cases, domain protocols only
│       ├── Infrastructure/    ← AVFoundation, Vision, Speech, SwiftData
│       └── Presentation/
│           ├── UIKit/         ← GCD, delegates, KVO, NotificationCenter
│           └── SwiftUI/       ← @Observable, async/await, NavigationStack
│
└── AppCore                    ← composition root, DI container, wiring
```

### The dependency rule

```
Dependencies point inward only. Inner layers never import outer layers.

AppCore          → imports everything
FeatureContracts → imported by AppCore + features
Resume           → imports FeatureContracts + PlatformContracts only
PlatformContracts → imports Foundation only
Logging          → imported by AppCore only — never by features
```

Swift packages enforce this at compile time — not by convention, not by code review. If a dependency is wrong the project does not compile.

### Key architectural decisions

| Decision | Choice | Why |
|---|---|---|
| Boundary enforcement | Swift packages | Compile-time guarantee — not convention |
| DI container | Custom factory-based | No third party, no singleton, no shared state |
| Presentation paths | UIKit + SwiftUI both | Practice both deeply — not a migration |
| ViewModel strategy | Separate per path | GCD (UIKit) vs async/await (SwiftUI) |
| ML inference | On-device only | Privacy non-negotiable |
| State modeling | Type-driven enums | Illegal states unrepresentable |

> Full architecture decision log → [Discussions](https://github.com/Ives-algorhym/MySkillo/discussions/categories/architecture-decision)

---

## Feature — Video Resume + Core ML Interview Coach

The flagship feature. An iOS engineer records a 60–90 second "Tell me about yourself" answer and receives a coached report card scored across five dimensions.

### What makes it technically sophisticated

**Domain layer — zero framework imports**
```
Take                  — central domain entity. A single recording attempt.
VideoResume           — the user's promoted active Take shown on profile.
CoachingReport        — analysis result. Max 3 Suggestions. Enforced by type.
InterviewScore        — bounded 0–100. Failable init. Never a raw Int.
TakeDuration          — bounded 0–90s. Domain rule in the type — not the caller.
TakeStatus            — enum. .recorded .analyzing .analyzed .failed .discarded
                        Illegal combinations are unrepresentable.
```

**Analysis pipeline — structured concurrency**
```
AnalyzeTakeUseCase
  ├── async let: TranscriptAnalysis  (SFSpeechRecognizer — on device)
  └── async let: FaceAnalysis        (Vision — 2fps frame sampling)
  await both →
  ├── NLPScoring      (depends on transcript)
  └── PacingAnalysis  (depends on WPM)
  → CoachingReport assembled
```

**Dual presentation — same domain, two paradigms**
```
UIKit path    GCD · DispatchGroup · KVO · delegates · completion handlers
SwiftUI path  @Observable · async/await · AsyncStream · TaskGroup
```

Both paths consume identical use cases and infrastructure. The domain never knows which presentation layer is running.

### Scoring dimensions

| Dimension | Source | Signal |
|---|---|---|
| Technical depth | NLP keyword tier matching | junior / mid / senior framework signals |
| Eye contact | VNDetectFaceLandmarksRequest | gaze direction vs camera axis |
| Pacing | WordsPerMinute | ideal: 130–160 WPM |
| Structure | STAR-P pattern detection | situation · technology · achievement · role · passion |
| Filler words | SFSpeechRecognizer transcript | "um", "like", "basically" frequency |

---

## Engineering methodology

This project follows a strict methodology stack applied in order before any code is written.

### Domain-Driven Design

A ubiquitous language was defined and frozen before any type was created. Every term in code maps exactly to a term the PM and Designer would recognize.

> Full ubiquitous language → [Wiki: Ubiquitous Language](https://github.com/Ives-algorhym/MySkillo/wiki/Feature-—-Video-Resume-—-Ubiquitous-Language)

```
Never say       Always say
──────────────  ──────────────────
video           Take
result          CoachingReport
score           InterviewScore (never raw Int)
analyze         AnalyzeTakeUseCase
publish         PromoteTake
feedback        Suggestion
```

### Type-Driven Design

Business rules live in the type system — not in guard statements, not in comments.

```swift
// Cannot be constructed with a value outside 0–100
struct InterviewScore {
    init?(_ value: Int) {
        guard value >= 0, value <= 100 else { return nil }
        self.value = value
    }
}

// Cannot be promoted without a CoachingReport
struct VideoResume {
    init?(from take: Take) {
        guard take.isPromotable else { return nil }
        // ...
    }
}
```

### Behavior-Driven Development

38 scenarios across 6 features written in plain language before a single test file was created. Each scenario maps directly to a failing test in the TDD cycle.

> Full BDD scenario suite → [Wiki: BDD Scenarios](https://github.com/Ives-algorhym/MySkillo/wiki/Feature-—-Video-Resume-—-BDD-Scenarios)

```
Feature: Recording a Take

  Scenario: Recording stops automatically at 90 seconds
    Given a RecordingSession is active
    When  90 seconds elapse
    Then  the RecordingSession stops automatically
    And   a Take is saved with duration of 90 seconds
    And   the analysis pipeline begins
```

### Test-Driven Development

Strict red → green → refactor. Sad path first. No production code without a failing test. Swift Testing framework — not XCTest.

```swift
// Sad path first
@Suite("Take")
struct TakeTests {
    @Suite("isAnalyzable")
    struct IsAnalyzableTests {
        @Test func whenStatusIsDiscarded_returnsFalse() {
            let take = Take(status: .discarded)
            #expect(take.isAnalyzable == false)
        }
    }
}
```

---

## Tech stack

| Category | Technology |
|---|---|
| Language | Swift 5.9 |
| UI — UIKit path | UIKit · UIViewController · UINavigationController |
| UI — SwiftUI path | SwiftUI · NavigationStack · @Observable (iOS 17) |
| Async — UIKit | GCD · DispatchGroup · completion handlers · KVO |
| Async — SwiftUI | async/await · structured concurrency · AsyncStream · TaskGroup |
| Recording | AVFoundation · AVCaptureSession · AVCaptureMovieFileOutput |
| Face analysis | Vision · VNDetectFaceLandmarksRequest · AVAssetImageGenerator |
| Speech | Speech · SFSpeechRecognizer · on-device · en-US |
| ML scoring | Rules-based NLP (v1) · Create ML NLP classifier (v2) |
| Location | MapKit · MKLocalSearch · no CoreLocation permission |
| Persistence | SwiftData |
| Testing | Swift Testing · XCTest (integration) |
| DI | Custom factory-based container — no third party |
| Architecture | Clean Architecture · MVVM · Coordinator |
| Methodology | DDD · Type-Driven · BDD · TDD |

---

## Project intelligence

This is where the work lives. Not just the code.

| Resource | Description |
|---|---|
| [PRD v1.0](https://github.com/Ives-algorhym/MySkillo/wiki/Feature-%E2%80%90-Video-Resume-PRD-v1.0) | Product requirements — problem, KPIs, 6-day timeline, risks |
| [Ubiquitous Language](https://github.com/Ives-algorhym/MySkillo/wiki/Feature-—-Video-Resume-—-Ubiquitous-Language) | Every domain term defined and frozen before code |
| [Architecture Overview](https://github.com/Ives-algorhym/MySkillo/wiki/Architecture-Overview) | Package map, dependency rule, communication patterns |
| [BDD Scenarios](https://github.com/Ives-algorhym/MySkillo/wiki/Feature-—-Video-Resume-—-BDD-Scenarios) | 38 scenarios across 6 features — the test contract |
| [Project structure](https://github.com/Ives-algorhym/MySkillo/discussions/68) | Why packages, dependency rule, communication patterns |
| [Discussion #2 — PlatformContracts][d2] | Logging abstraction design |
| [Discussion #3 — Logging][d3] | LogSink fan-out, DefaultLogger, InMemoryLogSink |
| [Discussion #4 — FeatureContracts][d4] | UIKit + SwiftUI boundary contracts |
| [Discussion #5 — AppCore](https://github.com/Ives-algorhym/MySkillo/discussions/7) | Composition root, DI container, wiring decisions |
| [Discussion #47 — Video Resume kickoff](https://github.com/Ives-algorhym/MySkillo/discussions/45) | Full cross-functional feature kickoff thread |
| [GitHub Issues](https://github.com/Ives-algorhym/MySkillo/issues) | 23 tickets across domain · application · infrastructure · presentation |

---

## What I am practicing in this project

### UIKit deep dive
- GCD — `DispatchQueue`, `DispatchGroup`, `DispatchWorkItem`
- KVO — observing `AVCaptureSession` state changes
- Delegate pattern — `AVCaptureFileOutputRecordingDelegate`
- `NotificationCenter` — system audio session interruptions
- Manual memory management — weak delegates, capture lists
- `UIViewController` lifecycle — `viewDidLoad`, `viewWillAppear`, layout
- `UINavigationController` — push/pop, custom transitions
- `UIActivityViewController` — share sheet with custom thumbnail

### SwiftUI deep dive
- `@Observable` macro (iOS 17) — replacing `ObservableObject`
- `NavigationStack` — type-safe routing with `NavigationPath`
- `async/await` — structured concurrency in ViewModels
- `AsyncStream` — bridging delegate callbacks to async sequences
- `TaskGroup` — concurrent pipeline in `AnalyzeTakeUseCase`
- SwiftUI animations — matched geometry, custom transitions
- `UIViewControllerRepresentable` — bridging AVFoundation preview layer
- Accessibility — VoiceOver, Dynamic Type, reduced motion

---

## Current status

| Area | Status |
|---|---|
| Project structure + packages | ✅ Complete |
| Architecture discussions #1–#5 | ✅ Complete |
| Domain layer — ticket #1 | 🔄 In progress |
| Domain layer — tickets #2–#7 | ⏳ Pending |
| Application layer | ⏳ Pending |
| Infrastructure layer | ⏳ Pending |
| Presentation — UIKit | ⏳ Pending |
| Presentation — SwiftUI | ⏳ Pending |
| TestFlight build | ⏳ Pending |

---

## Contact

**Ives Murillo**  
iOS Engineer  
[LinkedIn][linkedin] · [GitHub][github]

> Available for senior iOS engineering roles.
> Open to UIKit, SwiftUI, or hybrid codebases.
> Based in Sunnyvale, CA — open to remote.

