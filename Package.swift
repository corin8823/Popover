// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "Popover",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "Popover",
            targets: ["Popover"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Popover",
            dependencies: [],
            path: "Classes/"),
    ],
    swiftLanguageVersions: [.v4, .v5]
)
