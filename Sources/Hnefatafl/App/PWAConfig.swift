struct AppIcon: Equatable {
    let src: String
    let sizes: String
    let type: String
}

struct WebAppManifest: Equatable {
    let name: String
    let shortName: String
    let startUrl: String
    let display: String
    let themeColor: String
    let backgroundColor: String
    let icons: [AppIcon]
}

struct PWAConfig {
    static let manifest = WebAppManifest(
        name: "Hnefatafl",
        shortName: "Hnefatafl",
        startUrl: "/",
        display: "standalone",
        themeColor: "#5c3a1e",
        backgroundColor: "#1a1207",
        icons: [
            AppIcon(src: "/icons/icon-192.png", sizes: "192x192", type: "image/png"),
            AppIcon(src: "/icons/icon-512.png", sizes: "512x512", type: "image/png"),
        ]
    )
}

struct ServiceWorkerConfig {
    static let cacheName = "hnefatafl-v1"
    static let filesToCache: [String] = [
        "/",
        "/index.html",
        "/main.wasm",
        "/main.js",
        "/style.css",
    ]
}
