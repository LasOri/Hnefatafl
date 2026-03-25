import Testing
@testable import Hnefatafl

@Suite("Move Log Entry Tests")
struct MoveLogEntryTests {

    @Test("notation format is correct")
    func notationFormat() {
        let move = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 4)
        let entry = MoveLogEntry(moveNumber: 1, player: .attacker, move: move, isCapture: false)
        #expect(entry.notation == "1. A1-E1")
    }

    @Test("capture flag is stored")
    func captureFlag() {
        let move = Move(fromRow: 3, fromCol: 5, toRow: 3, toCol: 7)
        let entry = MoveLogEntry(moveNumber: 5, player: .defender, move: move, isCapture: true)
        #expect(entry.isCapture)
    }

    @Test("equatable conformance")
    func equatable() {
        let move = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 1)
        let a = MoveLogEntry(moveNumber: 1, player: .attacker, move: move, isCapture: false)
        let b = MoveLogEntry(moveNumber: 1, player: .attacker, move: move, isCapture: false)
        #expect(a == b)
    }

    @Test("different move numbers are not equal")
    func differentMoveNumbers() {
        let move = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 1)
        let a = MoveLogEntry(moveNumber: 1, player: .attacker, move: move, isCapture: false)
        let b = MoveLogEntry(moveNumber: 2, player: .attacker, move: move, isCapture: false)
        #expect(a != b)
    }

    @Test("notation uses correct column letters")
    func columnLetters() {
        let move = Move(fromRow: 9, fromCol: 10, toRow: 0, toCol: 10)
        let entry = MoveLogEntry(moveNumber: 3, player: .defender, move: move, isCapture: false)
        #expect(entry.notation == "3. K10-K1")
    }

    @Test("player is stored correctly")
    func playerStored() {
        let move = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 1)
        let entry = MoveLogEntry(moveNumber: 1, player: .defender, move: move, isCapture: false)
        #expect(entry.player == .defender)
    }
}
