//
//  WordsPerMinute.swift
//  Resume
//
//  Created by Ives Murillo on 7/20/26.
//

struct WordsPerMinute: Equatable {
    let value: Int

    init?(_ value: Int) {
        guard value > 0, value <= 300 else { return nil }
        self.value = value
    }

    var pacingAssessment: PacingAssessment {
        switch value {
        case 0 ... 99: return .tooSlow
        case 100 ... 129: return .slightlyBelowIdeal
        case 130 ... 160: return .ideal
        case 161 ... 180: return .slightlyAboveIdeal
        case 181 ... 300: return .tooFast
        default: preconditionFailure("WPM \(value) outside valid range 1-300")
        }
    }
}
