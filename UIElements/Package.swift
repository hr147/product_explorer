// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "UIElements",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "UIElements",
            targets: ["UIElements"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/onevcat/Kingfisher.git", .upToNextMajor(from: "5.8.0"))
    ],
    targets: [
        .target(
            name: "UIElements",
            dependencies: ["Kingfisher"]),
        .testTarget(
            name: "UIElementsTests",
            dependencies: ["UIElements"]),
    ]
)
