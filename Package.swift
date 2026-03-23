// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "Hnefatafl",
    platforms: [
        .macOS(.v13),
        .iOS(.v16)
    ],
    products: [
        .executable(
            name: "Hnefatafl",
            targets: ["Hnefatafl"]
        )
    ],
    dependencies: [
        .package(path: "../LINKER"),
        .package(url: "https://github.com/swiftwasm/JavaScriptKit", from: "0.46.0")
    ],
    targets: [
        .executableTarget(
            name: "Hnefatafl",
            dependencies: [
                .product(name: "LINKER", package: "LINKER"),
                .product(name: "JavaScriptEventLoop", package: "JavaScriptKit")
            ]
        ),
        .testTarget(
            name: "HnefataflTests",
            dependencies: [
                "Hnefatafl",
                .product(name: "LINKER", package: "LINKER"),
                .product(name: "LINKERTesting", package: "LINKER")
            ]
        )
    ]
)
