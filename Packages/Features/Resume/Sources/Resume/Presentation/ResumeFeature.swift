//
//  ResumeFeature.swift
//  Resume
//
//  Created by Ives Murillo on 3/11/26.
//

import FeatureContracts
import UIKit

@available(iOS 13.0, *)
public struct ResumeFeature: ResumeFeatureProviding {
    
    public init() {}

    @MainActor public func makeResumeViewController() -> UIViewController {
        ResumeViewController()
    }
}
