// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FeedGenerator",
    platforms: [.macOS(.v14)],
    products: [
        .library(name: "FeedGenerator", targets: ["FeedGenerator"])
    ],
    dependencies: [
        .package(url: "https://github.com/thecatalinstan/CSFeedKit", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "FeedGenerator",
            dependencies: [
                "CSFeedKit"
            ]
        )
    ]
)
