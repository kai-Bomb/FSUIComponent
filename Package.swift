// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FSUIComponent",
    defaultLocalization: "en",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "FSUIComponent",
            targets: ["FSUIComponent"]
        ),
    ],
    targets: [
        .target(
            name: "FSUIComponent"
        ),
    ]
)
