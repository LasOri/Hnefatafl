import Testing
@testable import Hnefatafl

@Suite("CaptureHistoryEntry Tests")
struct CaptureHistoryEntryTests {
    @Test("Creates entry with all properties")
    func createEntry() {
        let entry = CaptureHistoryEntry(
            moveNumber: 5,
            capturedPiece: .attacker,
            row: 3,
            col: 4,
            capturedBy: .defender
        )
        #expect(entry.moveNumber == 5)
        #expect(entry.capturedPiece == .attacker)
        #expect(entry.row == 3)
        #expect(entry.col == 4)
        #expect(entry.capturedBy == .defender)
    }

    @Test("Description for attacker capture")
    func attackerCaptureDescription() {
        let entry = CaptureHistoryEntry(
            moveNumber: 3,
            capturedPiece: .defender,
            row: 2,
            col: 7,
            capturedBy: .attacker
        )
        #expect(entry.description == "Move 3: Attacker captured Defender at (2, 7)")
    }

    @Test("Description for defender capture")
    func defenderCaptureDescription() {
        let entry = CaptureHistoryEntry(
            moveNumber: 8,
            capturedPiece: .attacker,
            row: 5,
            col: 5,
            capturedBy: .defender
        )
        #expect(entry.description == "Move 8: Defender captured Attacker at (5, 5)")
    }

    @Test("King capture description")
    func kingCaptureDescription() {
        let entry = CaptureHistoryEntry(
            moveNumber: 20,
            capturedPiece: .king,
            row: 5,
            col: 5,
            capturedBy: .attacker
        )
        #expect(entry.description.contains("King"))
    }

    @Test("Equatable conformance works")
    func equatable() {
        let a = CaptureHistoryEntry(moveNumber: 1, capturedPiece: .attacker, row: 0, col: 0, capturedBy: .defender)
        let b = CaptureHistoryEntry(moveNumber: 1, capturedPiece: .attacker, row: 0, col: 0, capturedBy: .defender)
        let c = CaptureHistoryEntry(moveNumber: 2, capturedPiece: .attacker, row: 0, col: 0, capturedBy: .defender)
        #expect(a == b)
        #expect(a != c)
    }

    @Test("Different capture pieces produce different descriptions")
    func differentPieceDescriptions() {
        let attackerEntry = CaptureHistoryEntry(moveNumber: 1, capturedPiece: .attacker, row: 0, col: 0, capturedBy: .defender)
        let defenderEntry = CaptureHistoryEntry(moveNumber: 1, capturedPiece: .defender, row: 0, col: 0, capturedBy: .attacker)
        #expect(attackerEntry.description != defenderEntry.description)
    }
}
