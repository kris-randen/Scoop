// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Scoop",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Scoop",
            targets: ["Scoop"]),
    ],
    dependencies: [
            // Other dependencies
            .package(url: "https://github.com/apple/swift-collections.git", .upToNextMajor(from: "1.0.6")),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Scoop",
            dependencies: [
                        .product(name: "OrderedCollections", package: "swift-collections")
                    ]),
        .testTarget(
            name: "ScoopTests",
            dependencies: ["Scoop"]),
    ]
)
