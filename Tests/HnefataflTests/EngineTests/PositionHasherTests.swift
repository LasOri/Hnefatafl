import Testing
@testable import Hnefatafl

@Suite("PositionHasher Tests")
struct PositionHasherTests {

    @Test("same position same hash")
    func samePositionSameHash() {
        let pos1 = Position.copenhagenStart()
        let pos2 = Position.copenhagenStart()
        #expect(PositionHasher.hash(position: pos1) == PositionHasher.hash(position: pos2))
    }

    @Test("different positions different hash")
    func differentPositionsDifferentHash() {
        let pos1 = Position.copenhagenStart()
        let pos2 = Position(cells: Array(repeating: nil, count: 121))
        #expect(PositionHasher.hash(position: pos1) != PositionHasher.hash(position: pos2))
    }

    @Test("starting position has non-zero hash")
    func startingNonZero() {
        let position = Position.copenhagenStart()
        #expect(PositionHasher.hash(position: position) != 0)
    }

    @Test("empty position has consistent hash")
    func emptyConsistent() {
        let pos1 = Position(cells: Array(repeating: nil, count: 121))
        let pos2 = Position(cells: Array(repeating: nil, count: 121))
        #expect(PositionHasher.hash(position: pos1) == PositionHasher.hash(position: pos2))
    }

    @Test("incremental update changes hash")
    func incrementalUpdateChanges() {
        let position = Position.copenhagenStart()
        let original = PositionHasher.hash(position: position)
        let updated = PositionHasher.incrementalUpdate(
            hash: original, fromRow: 0, fromCol: 3, toRow: 0, toCol: 2, piece: .attacker
        )
        #expect(updated != original)
    }

    @Test("hash is deterministic")
    func hashDeterministic() {
        let position = Position.copenhagenStart()
        let h1 = PositionHasher.hash(position: position)
        let h2 = PositionHasher.hash(position: position)
        let h3 = PositionHasher.hash(position: position)
        #expect(h1 == h2)
        #expect(h2 == h3)
    }
}
