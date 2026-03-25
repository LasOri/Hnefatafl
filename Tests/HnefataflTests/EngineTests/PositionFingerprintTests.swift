import Testing
@testable import Hnefatafl

@Suite("PositionFingerprint Tests")
struct PositionFingerprintTests {

    @Test("same position produces same fingerprint")
    func deterministic() {
        let pos = Position.copenhagenStart()
        let a = PositionFingerprint.compute(pos)
        let b = PositionFingerprint.compute(pos)
        #expect(a == b)
    }

    @Test("different positions produce different fingerprints")
    func different() {
        let a = PositionFingerprint.compute(Position.copenhagenStart())
        let empty = Position(cells: Array(repeating: nil, count: 121))
        let b = PositionFingerprint.compute(empty)
        #expect(a != b)
    }

    @Test("empty board fingerprint is non-zero")
    func emptyNonZero() {
        let empty = Position(cells: Array(repeating: nil, count: 121))
        let fp = PositionFingerprint.compute(empty)
        #expect(fp != 0)
    }

    @Test("fingerprint changes after move")
    func changesAfterMove() {
        let pos = Position.copenhagenStart()
        let moves = pos.allLegalMoves(for: .attacker)
        let after = pos.applyMove(moves[0])
        let fpBefore = PositionFingerprint.compute(pos)
        let fpAfter = PositionFingerprint.compute(after)
        #expect(fpBefore != fpAfter)
    }

    @Test("fingerprint is UInt64")
    func typeCheck() {
        let fp: UInt64 = PositionFingerprint.compute(Position.copenhagenStart())
        #expect(fp > 0)
    }

    @Test("single piece position has unique fingerprint")
    func singlePiece() {
        let pos1 = PositionBuilder().place(.king, row: 0, col: 0).build()
        let pos2 = PositionBuilder().place(.king, row: 0, col: 1).build()
        let fp1 = PositionFingerprint.compute(pos1)
        let fp2 = PositionFingerprint.compute(pos2)
        #expect(fp1 != fp2)
    }

    @Test("piece type matters for fingerprint")
    func pieceTypeMatters() {
        let pos1 = PositionBuilder().place(.attacker, row: 0, col: 0).place(.king, row: 5, col: 5).build()
        let pos2 = PositionBuilder().place(.defender, row: 0, col: 0).place(.king, row: 5, col: 5).build()
        let fp1 = PositionFingerprint.compute(pos1)
        let fp2 = PositionFingerprint.compute(pos2)
        #expect(fp1 != fp2)
    }

    @Test("compute is fast for full board")
    func performance() {
        let pos = Position.copenhagenStart()
        for _ in 0..<1000 {
            _ = PositionFingerprint.compute(pos)
        }
    }
}
