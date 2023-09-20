// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MoviesApp",
    products: [
        .executable(name: "MoviesApp", targets: ["MoviesApp"])
    ],
    dependencies: [
        .package(url: "https://github.com/fastlane/fastlane", from: "2.179.0"),
        .package(url: "https://github.com/youtube/youtube-ios-player-helper", from: "1.0.0"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "10.0.0")
    ],
    targets: [
        .target(
            name: "MoviesApp",
            dependencies: [
                .product(name: "Fastlane", package: "fastlane"),
                .product(name: "YouTube-Player-iOS-Helper", package: "youtube-ios-player-helper"),
                .product(name: "Firebase", package: "firebase-ios-sdk"),
            ]
        ),
        .testTarget(
            name: "MoviesAppTests",
            dependencies: ["MoviesApp"]
        )
    ]
)
