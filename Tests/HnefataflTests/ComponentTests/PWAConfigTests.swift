import Testing
@testable import Hnefatafl

@Suite("PWA Config Tests")
struct PWAConfigTests {

    @Test("manifest has correct app name")
    func manifestName() {
        let manifest = PWAConfig.manifest
        #expect(manifest.name == "Hnefatafl")
        #expect(manifest.shortName == "Hnefatafl")
    }

    @Test("manifest has standalone display mode")
    func standaloneDisplay() {
        #expect(PWAConfig.manifest.display == "standalone")
    }

    @Test("manifest has theme color")
    func themeColor() {
        #expect(!PWAConfig.manifest.themeColor.isEmpty)
    }

    @Test("manifest has start URL")
    func startURL() {
        #expect(PWAConfig.manifest.startUrl == "/")
    }

    @Test("ServiceWorkerConfig has cache name")
    func cacheName() {
        #expect(!ServiceWorkerConfig.cacheName.isEmpty)
        #expect(ServiceWorkerConfig.cacheName.contains("hnefatafl"))
    }

    @Test("ServiceWorkerConfig lists files to cache")
    func cacheFiles() {
        #expect(!ServiceWorkerConfig.filesToCache.isEmpty)
        #expect(ServiceWorkerConfig.filesToCache.contains("/"))
        #expect(ServiceWorkerConfig.filesToCache.contains("/index.html"))
    }

    @Test("manifest icons include 192 and 512 sizes")
    func iconSizes() {
        let sizes = PWAConfig.manifest.icons.map(\.sizes)
        #expect(sizes.contains("192x192"))
        #expect(sizes.contains("512x512"))
    }

    @Test("manifest background color is set")
    func backgroundColor() {
        #expect(!PWAConfig.manifest.backgroundColor.isEmpty)
    }
}
