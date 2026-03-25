import Testing
@testable import Hnefatafl

@Suite("Territory Balance Tests")
struct TerritoryBalanceTests {

    @Test("empty board has zero balance")
    func emptyBoardZero() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let result = TerritoryBalance.evaluate(position: position)
        #expect(result == 0)
    }

    @Test("empty board has zero controlled squares for attacker")
    func emptyBoardZeroAttacker() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(TerritoryBalance.controlledSquares(position: position, player: .attacker) == 0)
    }

    @Test("empty board has zero controlled squares for defender")
    func emptyBoardZeroDefender() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(TerritoryBalance.controlledSquares(position: position, player: .defender) == 0)
    }

    @Test("starting position both sides have territory")
    func startingPositionBothHaveTerritory() {
        let position = Position.copenhagenStart()
        let atk = TerritoryBalance.controlledSquares(position: position, player: .attacker)
        let def = TerritoryBalance.controlledSquares(position: position, player: .defender)
        #expect(atk > 0)
        #expect(def > 0)
    }

    @Test("single piece controls its reachable squares")
    func singlePieceTerritory() {
        let position = emptyBoard()
            .placing(.attacker, row: 5, col: 5)
            .build()
        let controlled = TerritoryBalance.controlledSquares(position: position, player: .attacker)
        #expect(controlled > 0)
    }

    @Test("evaluate returns positive when attacker has more territory")
    func evaluatePositive() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 5] = .attacker
        cells[1 * 11 + 5] = .attacker
        cells[2 * 11 + 5] = .attacker
        cells[10 * 11 + 10] = .king
        let position = Position(cells: cells)
        let balance = TerritoryBalance.evaluate(position: position)
        #expect(balance > 0)
    }

    @Test("controlled squares never exceeds board size squared")
    func controlledSquaresBound() {
        let position = Position.copenhagenStart()
        let controlled = TerritoryBalance.controlledSquares(position: position, player: .attacker)
        #expect(controlled <= Position.boardSize * Position.boardSize)
    }
}
