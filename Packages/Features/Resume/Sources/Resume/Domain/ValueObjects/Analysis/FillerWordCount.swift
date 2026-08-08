//
//  FillerWordCount.swift
//  Resume
//
//  Created by Ives Murillo on 7/20/26.
//

struct FillerWordCount: Equatable {
    let count: Int

    init?(_ count: Int) {
        guard count >= 0 else { return nil }
        self.count = count
    }
}
