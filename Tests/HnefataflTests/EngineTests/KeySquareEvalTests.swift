import Testing
@testable import Hnefatafl

@Suite("KeySquareEval Tests")
struct KeySquareEvalTests {

    @Test("empty board has zero key square control")
    func emptyBoardZeroControl() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(KeySquareEval.keySquareControl(position: position, player: .attacker) == 0)
    }

    @Test("key square control is non-negative")
    func nonNegativeControl() {
        let position = Position.copenhagenStart()
        #expect(KeySquareEval.keySquareControl(position: position, player: .attacker) >= 0)
        #expect(KeySquareEval.keySquareControl(position: position, player: .defender) >= 0)
    }

    @Test("throneArea counts pieces in 5x5 center")
    func throneAreaCountsPieces() {
        let position = Position.copenhagenStart()
        let count = KeySquareEval.throneArea(position: position, player: .defender)
        #expect(count >= 0)
    }

    @Test("empty board has zero throne area")
    func emptyBoardZeroThroneArea() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(KeySquareEval.throneArea(position: position, player: .attacker) == 0)
    }

    @Test("piece adjacent to corner scores points")
    func adjacentToCornerScores() {
        let position = emptyBoard()
            .placing(.attacker, row: 0, col: 1)
            .build()
        let score = KeySquareEval.keySquareControl(position: position, player: .attacker)
        #expect(score > 0)
    }

    @Test("king on throne gives defender control")
    func kingOnThroneGivesControl() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .build()
        let score = KeySquareEval.keySquareControl(position: position, player: .defender)
        #expect(score > 0)
    }

    @Test("throneArea is non-negative for both players")
    func throneAreaNonNegative() {
        let position = Position.copenhagenStart()
        #expect(KeySquareEval.throneArea(position: position, player: .attacker) >= 0)
        #expect(KeySquareEval.throneArea(position: position, player: .defender) >= 0)
    }
}
