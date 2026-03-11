//
//  ResumeViewController.swift
//  Resume
//
//  Created by Ives Murillo on 3/10/26.
//

import SwiftUI
import UIKit

@available(iOS 13.0, *)
final class ResumeViewController: UIViewController {

    private let contentStack = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray4

        contentStack.axis = .vertical
        contentStack.spacing = 20
        contentStack.alignment = .center

        view.addSubview(contentStack)
        view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate(
[
            contentStack.topAnchor
                .constraint(
                    equalTo: view.safeAreaLayoutGuide.topAnchor,
                    constant: 16
                ),
            contentStack.leadingAnchor
                .constraint(
                    equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                    constant: 16
                ),
            contentStack.trailingAnchor
                .constraint(
                    equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                    constant: -16
                ),
            contentStack.bottomAnchor
                .constraint(
                    equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                    constant: -16
                )

        ]
)
    }
}

@available(iOS 17.0, *)
#Preview {
    ResumeViewController()
}
