// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "Popover",
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
    ]
)
