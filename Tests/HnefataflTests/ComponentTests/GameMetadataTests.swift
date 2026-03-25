import Testing
@testable import Hnefatafl

@Suite("GameMetadata Tests")
struct GameMetadataTests {

    @Test("current version is 1.0")
    func currentVersion() {
        #expect(GameMetadata.currentVersion == "1.0")
    }

    @Test("default metadata has correct version")
    func defaultVersion() {
        let meta = GameMetadata.defaultMetadata()
        #expect(meta.version == "1.0")
    }

    @Test("default metadata variant is Copenhagen")
    func defaultVariant() {
        let meta = GameMetadata.defaultMetadata()
        #expect(meta.variant == "Copenhagen")
    }

    @Test("default metadata board size is 11")
    func defaultBoardSize() {
        let meta = GameMetadata.defaultMetadata()
        #expect(meta.boardSize == 11)
    }

    @Test("equatable conformance")
    func equatable() {
        let a = GameMetadata(version: "1.0", variant: "Copenhagen", createdDate: "2026-03-25", boardSize: 11)
        let b = GameMetadata(version: "1.0", variant: "Copenhagen", createdDate: "2026-03-25", boardSize: 11)
        #expect(a == b)
    }

    @Test("inequal when different variant")
    func inequalVariant() {
        let a = GameMetadata(version: "1.0", variant: "Copenhagen", createdDate: "2026-03-25", boardSize: 11)
        let b = GameMetadata(version: "1.0", variant: "Tablut", createdDate: "2026-03-25", boardSize: 9)
        #expect(a != b)
    }
}
