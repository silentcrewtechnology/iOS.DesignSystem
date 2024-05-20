// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "DesignSystem",
    platforms: [
        .iOS(.v13)
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
        .package(url: "https://gitlab.akbars.tech/abo/ios-resources-fonts.git", .upToNextMinor(from: "0.0.1")),
        .package(url: "https://gitlab.akbars.tech/abo/ios-resources-colors.git", .upToNextMinor(from: "0.0.3")),
        .package(url: "https://gitlab.akbars.tech/abo/ios-resources-icons.git", .upToNextMinor(from: "0.0.2")),
        .package(url: "https://gitlab.akbars.tech/abo/ios-resources-ui-components.git", .upToNextMinor(from: "0.0.46")),
    ],
    targets: [
        .target(
            name: "DesignSystem",
            dependencies: [
                .product(name: "iOS.Resources.Fonts", package: "ios-resources-fonts"),
                .product(name: "iOS.Resources.Colors", package: "ios-resources-colors"),
                .product(name: "iOS.Resources.Icons", package: "ios-resources-icons"),
                .product(name: "iOS.Resources.UiComponents", package: "ios-resources-ui-components"),
            ]
        ),
    ]
)
