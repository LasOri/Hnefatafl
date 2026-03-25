import Testing
@testable import Hnefatafl

@Suite("PieceGlyph Tests")
struct PieceGlyphTests {
    @Test("Attacker unicode glyph")
    func attackerUnicode() {
        let glyph = PieceGlyph.glyph(for: .attacker, style: .unicode)
        #expect(glyph.character == "\u{2659}")
    }

    @Test("Defender ascii glyph")
    func defenderAscii() {
        let glyph = PieceGlyph.glyph(for: .defender, style: .ascii)
        #expect(glyph.character == "D")
    }

    @Test("King simple glyph")
    func kingSimple() {
        let glyph = PieceGlyph.glyph(for: .king, style: .simple)
        #expect(glyph.character == "k")
    }

    @Test("GlyphStyle is CaseIterable with three cases")
    func glyphStyleCaseIterable() {
        #expect(GlyphStyle.allCases.count == 3)
    }

    @Test("Equatable conformance works")
    func equatable() {
        let a = PieceGlyph(piece: .attacker, style: .unicode)
        let b = PieceGlyph(piece: .attacker, style: .unicode)
        #expect(a == b)
    }

    @Test("Different pieces produce different glyphs")
    func differentPieces() {
        let attacker = PieceGlyph.glyph(for: .attacker, style: .ascii)
        let defender = PieceGlyph.glyph(for: .defender, style: .ascii)
        let king = PieceGlyph.glyph(for: .king, style: .ascii)
        #expect(attacker.character != defender.character)
        #expect(defender.character != king.character)
        #expect(attacker.character != king.character)
    }

    @Test("GlyphStyle raw values")
    func rawValues() {
        #expect(GlyphStyle.unicode.rawValue == "unicode")
        #expect(GlyphStyle.ascii.rawValue == "ascii")
        #expect(GlyphStyle.simple.rawValue == "simple")
    }
}
