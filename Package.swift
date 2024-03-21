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
        .package(url: "https://gitlab.akbars.tech/abo/ios-resources-fonts.git", exact: "0.0.1"),
    ],
    targets: [
        .target(
            name: "DesignSystem",
            dependencies: [
                .product(name: "SnapKit", package: "SnapKit"),
                .product(name: "iOS.Resources.Fonts", package: "ios-resources-fonts"),
                .target(name: "ImagesService")
            ]
        ),
        .target(
            name: "ImagesService",
            resources: [.process("Resources")]
        )
    ]
)
