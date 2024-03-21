// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ios.designsystem",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "ios.designsystem",
            targets: [
                "DesignSystem",
                "ImagesService",
            ]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/SnapKit/SnapKit.git", exact: "5.6.0"),
    ],
    targets: [
        .target(
            name: "DesignSystem",
            dependencies: [
                .product(name: "SnapKit", package: "SnapKit"),
                .target(name: "ImagesService")
            ]
        ),
        .target(
            name: "ImagesService",
            resources: [.process("Resources")]
        )
    ]
)
