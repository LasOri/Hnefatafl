import Testing
@testable import Hnefatafl

@Suite("Move Complexity Tests")
struct MoveComplexityTests {

    @Test("branching factor for attacker at start is positive")
    func attackerBranchingStart() {
        let position = Position.copenhagenStart()
        let bf = MoveComplexity.branchingFactor(position: position, player: .attacker)
        #expect(bf > 0)
    }

    @Test("branching factor for defender at start is positive")
    func defenderBranchingStart() {
        let position = Position.copenhagenStart()
        let bf = MoveComplexity.branchingFactor(position: position, player: .defender)
        #expect(bf > 0)
    }

    @Test("position complexity is sum of both sides")
    func positionComplexityIsSum() {
        let position = Position.copenhagenStart()
        let atk = MoveComplexity.branchingFactor(position: position, player: .attacker)
        let def = MoveComplexity.branchingFactor(position: position, player: .defender)
        let total = MoveComplexity.positionComplexity(position: position)
        #expect(total == atk + def)
    }

    @Test("starting position is not simple")
    func startNotSimple() {
        let position = Position.copenhagenStart()
        #expect(!MoveComplexity.isSimple(position: position))
    }

    @Test("near-empty position is simple with high threshold")
    func nearEmptyIsSimple() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 0, col: 0)
            .build()
        #expect(MoveComplexity.isSimple(position: position, threshold: 100))
    }
}
