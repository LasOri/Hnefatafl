import Testing
@testable import Hnefatafl

@Suite("PawnStructureAnalyzer Tests")
struct PawnStructureAnalyzerTests {

    @Test("isolated count on empty board is zero")
    func isolatedCountEmpty() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(PawnStructureAnalyzer.isolatedCount(position: position, player: .attacker) == 0)
    }

    @Test("isolated count on start position")
    func isolatedCountStart() {
        let position = Position.copenhagenStart()
        let isolated = PawnStructureAnalyzer.isolatedCount(position: position, player: .attacker)
        #expect(isolated >= 0)
        #expect(isolated <= position.attackerCount)
    }

    @Test("chain length on start position")
    func chainLengthStart() {
        let position = Position.copenhagenStart()
        let chain = PawnStructureAnalyzer.chainLength(position: position, player: .attacker)
        #expect(chain >= 1)
    }

    @Test("single piece is isolated")
    func singlePieceIsolated() {
        let position = emptyBoard()
            .placing(.attacker, row: 5, col: 5)
            .build()
        #expect(PawnStructureAnalyzer.isolatedCount(position: position, player: .attacker) == 1)
    }

    @Test("chain of 2 adjacent pieces")
    func chainOfTwo() {
        let position = emptyBoard()
            .placing(.attacker, row: 5, col: 5)
            .placing(.attacker, row: 5, col: 6)
            .build()
        #expect(PawnStructureAnalyzer.chainLength(position: position, player: .attacker) == 2)
        #expect(PawnStructureAnalyzer.isolatedCount(position: position, player: .attacker) == 0)
    }

    @Test("chain length >= isolated count never true when both present")
    func chainVsIsolated() {
        let position = emptyBoard()
            .placing(.attacker, row: 0, col: 0)
            .placing(.attacker, row: 5, col: 5)
            .placing(.attacker, row: 5, col: 6)
            .build()
        let chain = PawnStructureAnalyzer.chainLength(position: position, player: .attacker)
        let isolated = PawnStructureAnalyzer.isolatedCount(position: position, player: .attacker)
        #expect(chain == 2)
        #expect(isolated == 1)
    }
}
