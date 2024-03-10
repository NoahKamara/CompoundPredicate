// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CompoundPredicate",
    platforms: [
        .macOS(.v14),
        .iOS(.v17),
        .tvOS(.v17),
        .watchOS(.v10),
        .visionOS(.v1),
        .macCatalyst(.v17)
    ],
    products: [
        .library(
            name: "CompoundPredicate",
            targets: ["CompoundPredicate"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/noahkamara/swift-xctesting", branch: "main"),
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.1.0"),
        .package(url: "https://github.com/pointfreeco/xctest-dynamic-overlay", from: "1.1.1")
    ],
    targets: [
        .target(
            name: "CompoundPredicate",
            dependencies: [
                .product(name: "XCTestDynamicOverlay", package: "xctest-dynamic-overlay")
            ]
        ),
        .testTarget(
            name: "CompoundPredicateTests",
            dependencies: [
                "CompoundPredicate",
                .product(name: "XCTesting", package: "swift-xctesting")
            ]
//            linkerSettings: [
//                .unsafeFlags([
//                    "-Xlinker", "-sectcreate",
//                    "-Xlinker", "__TEXT",
//                    "-Xlinker", "__info_plist",
//                    "-Xlinker", "Tests/Info.plist",
//                ])
//            ]
        ),
    ]
)
