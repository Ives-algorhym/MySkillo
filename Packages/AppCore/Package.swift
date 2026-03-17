// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppCore",
    products: [
        .library(
            name: "AppCore",
            targets: ["AppCore"]
        ),
    ],
    dependencies: [
        .package(path: "../../Features/Resume"),
        .package(path: "../../Platform/Logging"),
    ],
    targets: [
        .target(
            name: "AppCore",
            dependencies: [
                .product(name: "Resume", package: "Resume"),
                .product(name: "Logging", package: "Logging"),
            ]
        ),
        .testTarget(
            name: "AppCoreTests",
            dependencies: ["AppCore"]
        ),
    ]
)
