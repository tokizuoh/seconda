// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "seconda",
    platforms: [.macOS(.v14)],
    dependencies: [
        .package(url: "https://github.com/thecatalinstan/CSFeedKit", from: "1.0.0")
    ],
    targets: [
        .executableTarget(
            name: "seconda",
            dependencies: [
                "CSFeedKit"
            ],
            resources: [
                .copy("Query.graphql"),
                .copy("token.txt")
            ]
        ),
    ]
)
