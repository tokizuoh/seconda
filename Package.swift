// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "seconda",
    platforms: [.macOS(.v14)],
    dependencies: [
        .package(url: "https://github.com/tokizuoh/CSFeedKit", branch: "add-pubdate-to-init")
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
        )
    ]
)
