// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CompoundPredicate",
    platforms: [
        .macOS(.v14),
        .iOS(.v17),
        .tvOS(.v17),
        .watchOS(.v10)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "CompoundPredicate",
            targets: ["CompoundPredicate"]),
    ],
    dependencies: [.package(url: "https://github.com/pointfreeco/swift-snapshot-testing.git", from: "1.15.3")],
    targets: [
        .target(
            name: "CompoundPredicate"),
        .testTarget(
            name: "CompoundPredicateTests",
            dependencies: ["CompoundPredicate", .product(name: "InlineSnapshotTesting", package: "swift-snapshot-testing")],
            linkerSettings: [
                .unsafeFlags([
                    "-Xlinker", "-sectcreate",
                    "-Xlinker", "__TEXT",
                    "-Xlinker", "__info_plist",
                    "-Xlinker", "Tests/Info.plist",
                ])
            ]
        ),
    ]
)
