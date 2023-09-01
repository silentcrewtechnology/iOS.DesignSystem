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
                "FontService",
                "ColorService"
            ]
        ),
    ],
    dependencies: [
        .package(url: "https://gitlab.akbars.tech/abo/ios.architecture", branch: "main"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.6.0")),
    ],
    targets: [
        .target(
            name: "DesignSystem",
            dependencies: [
                .product(name: "Architecture", package: "ios.architecture"),
                .product(name: "SnapKit", package: "SnapKit"),
                .target(name: "FontService"),
                .target(name: "ImagesService"),
                .target(name: "ColorService")
            ]
        ),
        .target(
            name: "FontService",
            resources: [.process("Fonts")]
        ),
        .target(
            name: "ImagesService",
            resources: [.process("Resources")]
        ),
        .target(
            name: "ColorService",
            resources: [.process("Resources")]
        )
    ]
)
