// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "seconda",
    platforms: [.macOS(.v14)],
    targets: [
        .executableTarget(
            name: "seconda",
            resources: [
                .copy("Query.graphql"),
                .copy("token.txt")
            ]
        ),
    ]
)
