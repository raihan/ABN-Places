// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Features",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Features",
            targets: ["Features"]),
    ],
    dependencies: [
        .package(path: "../UIComponents"),
        .package(path: "../LocationsApi"),
        .package(path: "../Models"),
        .package(path: "../Router")
    ],
    targets: [
        .target(
            name: "Features", dependencies: ["UIComponents", "LocationsApi", "Models", "Router"]),
        .testTarget(
            name: "FeaturesTests",
            dependencies: ["Features"]
        ),
    ]
)
