import Testing
@testable import Hnefatafl

@Suite("Attack Vector Tests")
struct AttackVectorTests {

    @Test("returns four vectors")
    func returnsFourVectors() {
        let pos = Position.copenhagenStart()
        let vectors = AttackVector.analyze(position: pos)
        #expect(vectors.count == 4)
    }

    @Test("directions are named")
    func directionsNamed() {
        let pos = Position.copenhagenStart()
        let vectors = AttackVector.analyze(position: pos)
        let names = vectors.map { $0.direction }
        #expect(names.contains("north"))
        #expect(names.contains("south"))
        #expect(names.contains("west"))
        #expect(names.contains("east"))
    }

    @Test("start position has attackers on edges")
    func startPositionHasAttackersOnEdges() {
        let pos = Position.copenhagenStart()
        let vectors = AttackVector.analyze(position: pos)
        let totalPieces = vectors.reduce(0) { $0 + $1.pieces }
        #expect(totalPieces > 0)
    }

    @Test("strength equals pieces times ten")
    func strengthEqualsPiecesTimes10() {
        let pos = Position.copenhagenStart()
        let vectors = AttackVector.analyze(position: pos)
        for v in vectors {
            #expect(v.strength == v.pieces * 10)
        }
    }

    @Test("empty board has zero pieces on edges")
    func emptyBoardZeroPieces() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let vectors = AttackVector.analyze(position: pos)
        for v in vectors {
            #expect(v.pieces == 0)
            #expect(v.strength == 0)
        }
    }
}
