import Testing
@testable import Hnefatafl

@Suite("Piece Style Tests")
struct PieceStyleTests {

    @Test("default style is classic")
    func defaultClassic() {
        #expect(PieceStyle.classic.name == "Classic")
    }

    @Test("all styles have names")
    func allHaveNames() {
        for style in PieceStyle.allCases {
            #expect(!style.name.isEmpty)
        }
    }

    @Test("all styles have CSS class")
    func allHaveCSSClass() {
        for style in PieceStyle.allCases {
            #expect(!style.cssClass.isEmpty)
        }
    }

    @Test("four styles available")
    func fourStyles() {
        #expect(PieceStyle.allCases.count == 4)
    }

    @Test("next cycles through styles")
    func nextCycles() {
        var style = PieceStyle.classic
        for _ in 0..<4 {
            style = style.next
        }
        #expect(style == .classic)
    }

    @Test("attacker symbol per style")
    func attackerSymbol() {
        for style in PieceStyle.allCases {
            #expect(!style.attackerSymbol.isEmpty)
        }
    }

    @Test("king symbol per style")
    func kingSymbol() {
        for style in PieceStyle.allCases {
            #expect(!style.kingSymbol.isEmpty)
        }
    }

    @Test("PieceStyle is Equatable")
    func equatable() {
        #expect(PieceStyle.classic == PieceStyle.classic)
        #expect(PieceStyle.classic != PieceStyle.modern)
    }
}
