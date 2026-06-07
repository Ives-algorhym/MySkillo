//
//  TakeStatus.swift
//  Resume
//
//  Created by Ives Murillo on 6/6/26.
//


enum TakeStatus {
    case discarded
    case recorded
    case analyzed(CoachingReport)
    case failed(TakeError)
    case analyzing
}
