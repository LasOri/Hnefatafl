import Testing
@testable import Hnefatafl

@Suite("MoveHistoryFormatter Tests")
struct MoveHistoryFormatterTests {

    @Test("empty moves returns empty list")
    func emptyMoves() {
        let entries = MoveHistoryFormatter.format(moves: [])
        #expect(entries.isEmpty)
    }

    @Test("first move is attacker")
    func firstMoveAttacker() {
        let moves = [Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 5)]
        let entries = MoveHistoryFormatter.format(moves: moves)
        #expect(entries[0].player == .attacker)
    }

    @Test("second move is defender")
    func secondMoveDefender() {
        let moves = [
            Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 5),
            Move(fromRow: 5, fromCol: 5, toRow: 5, toCol: 7)
        ]
        let entries = MoveHistoryFormatter.format(moves: moves)
        #expect(entries[1].player == .defender)
    }

    @Test("notation format is correct")
    func notationFormat() {
        let moves = [Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)]
        let entries = MoveHistoryFormatter.format(moves: moves)
        #expect(entries[0].notation == "a11-f11")
    }

    @Test("entry index matches position")
    func entryIndex() {
        let moves = [
            Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 1),
            Move(fromRow: 1, fromCol: 0, toRow: 1, toCol: 1)
        ]
        let entries = MoveHistoryFormatter.format(moves: moves)
        #expect(entries[0].index == 0)
        #expect(entries[1].index == 1)
    }
}
