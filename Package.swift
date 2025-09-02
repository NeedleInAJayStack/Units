// swift-tools-version:5.4

import PackageDescription

let package = Package(
    name: "Units",
    products: [
        .library(
            name: "Units",
            targets: ["Units"]
        ),
        .executable(
            name: "unit",
            targets: ["CLI"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.2.1"),
    ],
    targets: [
        .target(
            name: "Units",
            dependencies: []
        ),
        .executableTarget(
            name: "CLI",
            dependencies: [
                "Units",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]
        ),
        .testTarget(
            name: "UnitsTests",
            dependencies: ["Units"]
        ),
        .testTarget(
            name: "PerformanceTests",
            dependencies: ["Units"]
        ),
    ],
    swiftLanguageVersions: [.v5, .version("6")]
)
