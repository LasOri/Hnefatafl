import Testing
@testable import Hnefatafl

@Suite("Piece Selector Helper Tests")
struct PieceSelectorHelperTests {

    @Test("empty square returns nil")
    func emptySquareNil() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let result = PieceSelectorHelper.info(row: 0, col: 0, position: position, currentPlayer: .attacker)
        #expect(result == nil)
    }

    @Test("attacker piece returns info")
    func attackerPieceInfo() {
        let position = Position.copenhagenStart()
        let result = PieceSelectorHelper.info(row: 0, col: 3, position: position, currentPlayer: .attacker)
        #expect(result != nil)
        #expect(result!.piece == .attacker)
        #expect(result!.canSelect == true)
    }

    @Test("defender cannot select during attacker turn")
    func defenderCantSelectAttackerTurn() {
        let position = Position.copenhagenStart()
        let result = PieceSelectorHelper.info(row: 4, col: 4, position: position, currentPlayer: .attacker)
        #expect(result != nil)
        #expect(result!.canSelect == false)
    }

    @Test("move count is included in info")
    func moveCountIncluded() {
        let position = Position.copenhagenStart()
        let result = PieceSelectorHelper.info(row: 0, col: 3, position: position, currentPlayer: .attacker)
        #expect(result != nil)
        #expect(result!.moveCount >= 0)
    }

    @Test("king is a defender piece")
    func kingIsDefender() {
        let position = Position.copenhagenStart()
        let result = PieceSelectorHelper.info(row: 5, col: 5, position: position, currentPlayer: .defender)
        #expect(result != nil)
        #expect(result!.piece == .king)
        #expect(result!.canSelect == true)
    }
}
