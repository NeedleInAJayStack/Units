// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Units",
    products: [
        .library(
            name: "Units",
            targets: ["Units"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Units",
            dependencies: []),
        .testTarget(
            name: "UnitsTests",
            dependencies: ["Units"]),
    ]
)
