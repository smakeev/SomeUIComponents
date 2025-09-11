// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "SomeUIComponents",
    platforms: [
        .iOS("18.0")
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SomeUIComponents",
            targets: ["SomeUIComponents"]),
    ],
    dependencies: [
        // SwiftLog API
        .package(url: "https://github.com/apple/swift-log.git", from: "1.5.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SomeUIComponents",
            dependencies: [
                .product(name: "Logging", package: "swift-log")
            ],
            path: "SomeUIComponents"),
        .testTarget(
            name: "SomeUIComponentsTests",
            dependencies: ["SomeUIComponents"]
        ),
    ]
)
