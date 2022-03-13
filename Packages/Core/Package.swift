// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [
        .iOS("15.0")
    ],
    products: [
        .library(
            name: "Core",
            targets: ["Core"])
    ],
    targets: [
        .target(
            name: "Core",
            dependencies: [])
    ]
)
