// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "dynamic_color",
    platforms: [
        .macOS("10.14")
    ],
    products: [
        .library(name: "dynamic-color", targets: ["dynamic_color"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "dynamic_color",
            dependencies: [],
            resources: [
                .process("Resources"),
            ]
        )
    ]
)