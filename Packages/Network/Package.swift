// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Network",
    platforms: [
        .iOS("15.0")
    ],
    products: [
        .library(
            name: "Network",
            targets: ["Network"])
    ],
    targets: [
        .target(
            name: "Network",
            dependencies: []),
        .testTarget(
            name: "NetworkTests",
            dependencies: ["Network"])
    ]
)
