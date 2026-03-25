import Testing
@testable import Hnefatafl

@Suite("PieceIcon Tests")
struct PieceIconTests {
    @Test("Attacker icon has correct alt text")
    func attackerAltText() {
        let icon = PieceIcon.icon(for: .attacker)
        #expect(icon.altText == "Attacker")
    }

    @Test("Defender icon has correct alt text")
    func defenderAltText() {
        let icon = PieceIcon.icon(for: .defender)
        #expect(icon.altText == "Defender")
    }

    @Test("King icon has correct alt text")
    func kingAltText() {
        let icon = PieceIcon.icon(for: .king)
        #expect(icon.altText == "King")
    }

    @Test("Each icon has a non-empty symbol")
    func nonEmptySymbols() {
        let icons = PieceIcon.allIcons
        for icon in icons {
            #expect(!icon.symbol.isEmpty)
        }
    }

    @Test("allIcons contains exactly three icons")
    func allIconsCount() {
        #expect(PieceIcon.allIcons.count == 3)
    }

    @Test("Icon piece matches input piece")
    func pieceMatches() {
        let icon = PieceIcon.icon(for: .king)
        #expect(icon.piece == .king)
    }

    @Test("Equatable conformance works")
    func equatable() {
        let a = PieceIcon.icon(for: .attacker)
        let b = PieceIcon.icon(for: .attacker)
        #expect(a == b)
    }
}
