// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ControllerRouting",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "ControllerRouting",
                 targets: ["ControllerRouting"]
        ),
        
//        .executable(name: "Run", targets: ["Run"]),
//        .library(name: "App", targets: ["App"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.10.0"),
        .package(url: "https://github.com/vapor/fluent.git", from: "4.0.0"),
        .package(url: "https://github.com/vapor/fluent-sqlite-driver.git", from: "4.0.0-rc.2"),
        .package(url: "https://github.com/wickwirew/Runtime.git", from: "2.1.1")
    ],
    targets: [
        .target(name: "ControllerRouting", dependencies: [
            .product(name: "Vapor", package: "vapor"),
            .product(name: "Runtime", package: "Runtime")
        ]),
        
        .target(name: "App", dependencies: [
            .product(name: "Fluent", package: "fluent"),
            .product(name: "FluentSQLiteDriver", package: "fluent-sqlite-driver"),
            .product(name: "Vapor", package: "vapor"),
            "ControllerRouting"
        ]),
        .target(name: "Run", dependencies: ["App"]),
        
        .testTarget(name: "ControllerRoutingTests", dependencies: ["ControllerRouting"]),
    ]
)
