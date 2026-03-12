//
//  ResumeFeatureProviding.swift
//  FeatureContracts
//
//  Created by Ives Murillo on 3/11/26.
//

import UIKit

@MainActor
public protocol ResumeFeatureProviding {
    func makeResumeViewController() -> UIViewController
}
