// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "DesignSystem",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "DesignSystem",
            targets: [
                "DesignSystem",
            ]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/silentcrewtechnology/iOS.Resources.Fonts.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/silentcrewtechnology/iOS.Resources.Colors.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/silentcrewtechnology/iOS.Resources.Icons.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/silentcrewtechnology/iOS.Resources.UIComponents.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/silentcrewtechnology/iOS.Extensions.git", .upToNextMajor(from: "1.0.0"))
    ],
    targets: [
        .target(
            name: "DesignSystem",
            dependencies: [
                .product(name: "iOS.Resources.Fonts", package: "iOS.Resources.Fonts"),
                .product(name: "iOS.Resources.Colors", package: "iOS.Resources.Colors"),
                .product(name: "iOS.Resources.Icons", package: "iOS.Resources.Icons"),
                .product(name: "iOS.Resources.UiComponents", package: "iOS.Resources.UIComponents"),
                .product(name: "Extensions", package: "iOS.Extensions")
            ]
        ),
    ]
)
