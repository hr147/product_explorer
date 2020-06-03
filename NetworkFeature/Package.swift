// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "NetworkFeature",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "NetworkFeature",
            targets: ["NetworkFeature"]),
    ],
    dependencies: [
        // Using 'path', we can depend on a local package that's
        // located at a given path relative to our package's folder:
        .package(path: "../AbstractFeature"),
        .package(path: "../CommonUtilities")
    ],
    targets: [
        .target(
            name: "NetworkFeature",
            dependencies: ["AbstractFeature", "CommonUtilities"]),
        .testTarget(
            name: "NetworkFeatureTests",
            dependencies: ["NetworkFeature"]),
    ]
)
