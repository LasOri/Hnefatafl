import Testing
@testable import Hnefatafl

@Suite("Diagonal Control Tests")
struct DiagonalControlTests {

    @Test("empty board has zero diagonal threats")
    func emptyBoardZero() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(DiagonalControl.diagonalThreats(position: position, player: .attacker) == 0)
    }

    @Test("start position has more than zero threats")
    func startPositionPositive() {
        let position = Position.copenhagenStart()
        let threats = DiagonalControl.diagonalThreats(position: position, player: .attacker)
        #expect(threats > 0)
    }

    @Test("single isolated piece has zero threats")
    func singlePieceZero() {
        let position = emptyBoard()
            .placing(.attacker, row: 5, col: 5)
            .build()
        #expect(DiagonalControl.diagonalThreats(position: position, player: .attacker) == 0)
    }

    @Test("two diagonal pieces are counted")
    func twoDiagonalPieces() {
        let position = emptyBoard()
            .placing(.attacker, row: 3, col: 3)
            .placing(.defender, row: 4, col: 4)
            .build()
        let attackerThreats = DiagonalControl.diagonalThreats(position: position, player: .attacker)
        #expect(attackerThreats >= 1)
    }

    @Test("both players have threats on start position")
    func bothPlayers() {
        let position = Position.copenhagenStart()
        let attackerThreats = DiagonalControl.diagonalThreats(position: position, player: .attacker)
        let defenderThreats = DiagonalControl.diagonalThreats(position: position, player: .defender)
        #expect(attackerThreats > 0)
        #expect(defenderThreats > 0)
    }
}
