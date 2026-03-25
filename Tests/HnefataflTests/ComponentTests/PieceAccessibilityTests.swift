import Testing
@testable import Hnefatafl

@Suite("Piece Accessibility Tests")
struct PieceAccessibilityTests {

    @Test("attacker piece label")
    func attackerLabel() {
        #expect(PieceAccessibility.pieceLabel(.attacker) == "Attacker piece")
    }

    @Test("defender piece label")
    func defenderLabel() {
        #expect(PieceAccessibility.pieceLabel(.defender) == "Defender piece")
    }

    @Test("king piece label")
    func kingLabel() {
        #expect(PieceAccessibility.pieceLabel(.king) == "King piece")
    }

    @Test("square label uses letter-number format")
    func squareLabel() {
        let label = PieceAccessibility.squareLabel(row: 0, col: 0)
        #expect(label == "A11")
    }

    @Test("move label combines from and to")
    func moveLabel() {
        let move = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)
        let label = PieceAccessibility.moveLabel(move: move)
        #expect(label == "A11 to F11")
    }
}
