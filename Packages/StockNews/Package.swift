// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StockNews",
    platforms: [
        .iOS("15.0")
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(name: "StockNews", targets: ["StockNews"])
    ],
    dependencies: [
        .package(name: "Network", path: "../Network"),
        .package(name: "Core", path: "../Core")
    ],
    targets: [
        .target(
            name: "StockNews",
            dependencies: [
                "Core",
                "Network"
            ]),
        .testTarget(
            name: "StockNewsTests",
            dependencies: ["StockNews"])
    ]
)
