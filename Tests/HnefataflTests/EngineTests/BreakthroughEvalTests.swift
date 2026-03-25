import Testing
@testable import Hnefatafl

@Suite("Breakthrough Eval Tests")
struct BreakthroughEvalTests {

    @Test("no king returns zero")
    func noKingZero() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(BreakthroughEval.evaluate(position: position) == 0)
    }

    @Test("king near corner has high eval")
    func kingNearCornerHighEval() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 1] = .king
        let position = Position(cells: cells)
        let score = BreakthroughEval.evaluate(position: position)
        #expect(score > 100)
    }

    @Test("king in center with attackers has lower eval than king near corner without attackers")
    func kingCenterWithAttackersLowerThanCorner() {
        var cellsCenter: [Piece?] = Array(repeating: nil, count: 121)
        cellsCenter[5 * 11 + 5] = .king
        cellsCenter[5 * 11 + 3] = .attacker
        cellsCenter[5 * 11 + 7] = .attacker
        cellsCenter[3 * 11 + 5] = .attacker
        cellsCenter[7 * 11 + 5] = .attacker
        let posCenter = Position(cells: cellsCenter)

        var cellsCorner: [Piece?] = Array(repeating: nil, count: 121)
        cellsCorner[0 * 11 + 1] = .king
        let posCorner = Position(cells: cellsCorner)

        #expect(BreakthroughEval.evaluate(position: posCorner) > BreakthroughEval.evaluate(position: posCenter))
    }

    @Test("hasBreakthroughPotential false with no king")
    func hasBreakthroughFalseNoKing() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(BreakthroughEval.hasBreakthroughPotential(position: position) == false)
    }

    @Test("hasBreakthroughPotential true when king is near corner")
    func hasBreakthroughTrueNearCorner() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 1] = .king
        let position = Position(cells: cells)
        #expect(BreakthroughEval.hasBreakthroughPotential(position: position) == true)
    }

    @Test("blocked king has lower eval")
    func blockedKingLowerEval() {
        var cellsFree: [Piece?] = Array(repeating: nil, count: 121)
        cellsFree[2 * 11 + 2] = .king
        let posFree = Position(cells: cellsFree)

        var cellsBlocked: [Piece?] = Array(repeating: nil, count: 121)
        cellsBlocked[2 * 11 + 2] = .king
        cellsBlocked[2 * 11 + 1] = .attacker
        cellsBlocked[2 * 11 + 3] = .attacker
        cellsBlocked[1 * 11 + 2] = .attacker
        cellsBlocked[3 * 11 + 2] = .attacker
        let posBlocked = Position(cells: cellsBlocked)

        #expect(BreakthroughEval.evaluate(position: posFree) > BreakthroughEval.evaluate(position: posBlocked))
    }

    @Test("starting position has moderate eval")
    func startingPositionModerateEval() {
        let position = Position.copenhagenStart()
        let score = BreakthroughEval.evaluate(position: position)
        #expect(score > 0)
    }
}
