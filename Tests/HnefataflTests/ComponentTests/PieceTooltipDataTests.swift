import Testing
@testable import Hnefatafl

@Suite("PieceTooltipData Tests")
struct PieceTooltipDataTests {

    @Test("display info for attacker")
    func attackerDisplayInfo() {
        let tooltip = PieceTooltipData(piece: .attacker, row: 3, col: 7, legalMoveCount: 4, isUnderThreat: false)
        #expect(tooltip.displayInfo == "Attacker at (3,7) — 4 moves")
    }

    @Test("display info for king under threat")
    func kingThreatened() {
        let tooltip = PieceTooltipData(piece: .king, row: 5, col: 5, legalMoveCount: 2, isUnderThreat: true)
        #expect(tooltip.displayInfo == "King at (5,5) — 2 moves (threatened)")
    }

    @Test("display info for defender not threatened")
    func defenderSafe() {
        let tooltip = PieceTooltipData(piece: .defender, row: 0, col: 0, legalMoveCount: 0, isUnderThreat: false)
        #expect(tooltip.displayInfo == "Defender at (0,0) — 0 moves")
    }

    @Test("equality works for identical tooltips")
    func equalityWorks() {
        let a = PieceTooltipData(piece: .attacker, row: 1, col: 2, legalMoveCount: 3, isUnderThreat: true)
        let b = PieceTooltipData(piece: .attacker, row: 1, col: 2, legalMoveCount: 3, isUnderThreat: true)
        #expect(a == b)
    }

    @Test("different pieces are not equal")
    func differentPiecesNotEqual() {
        let a = PieceTooltipData(piece: .attacker, row: 1, col: 2, legalMoveCount: 3, isUnderThreat: false)
        let b = PieceTooltipData(piece: .defender, row: 1, col: 2, legalMoveCount: 3, isUnderThreat: false)
        #expect(a != b)
    }

    @Test("threat status affects display info")
    func threatAffectsDisplay() {
        let safe = PieceTooltipData(piece: .king, row: 5, col: 5, legalMoveCount: 1, isUnderThreat: false)
        let threatened = PieceTooltipData(piece: .king, row: 5, col: 5, legalMoveCount: 1, isUnderThreat: true)
        #expect(safe.displayInfo != threatened.displayInfo)
    }
}
