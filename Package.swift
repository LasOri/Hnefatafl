// swift-tools-version: 6.0
import PackageDescription
import Foundation

// JavaScriptEventLoop doesn't compile on macOS (requires WASM-only ExecutorFactory API).
// Use WASM_BUILD=1 env var for cross-compilation builds (set by Dockerfile).
let jsKitProducts: [Target.Dependency]
if ProcessInfo.processInfo.environment["WASM_BUILD"] != nil {
    jsKitProducts = [.product(name: "JavaScriptEventLoop", package: "JavaScriptKit")]
} else {
    jsKitProducts = []
}

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
            ] + jsKitProducts
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
