import Testing
@testable import Hnefatafl

@Suite("Piece Square Table Tests")
struct PieceSquareTableTests {

    @Test("attacker center value is highest")
    func attackerCenterHighest() {
        let centerVal = PieceSquareTable.value(piece: .attacker, row: 5, col: 5)
        let edgeVal = PieceSquareTable.value(piece: .attacker, row: 0, col: 0)
        #expect(centerVal > edgeVal)
    }

    @Test("defender edge distance scoring")
    func defenderEdgeDistance() {
        let cornerVal = PieceSquareTable.value(piece: .defender, row: 0, col: 0)
        let centerVal = PieceSquareTable.value(piece: .defender, row: 5, col: 5)
        #expect(centerVal > cornerVal)
        #expect(cornerVal == 0)
    }

    @Test("king corner proximity scoring")
    func kingCornerProximity() {
        let cornerVal = PieceSquareTable.value(piece: .king, row: 0, col: 0)
        let centerVal = PieceSquareTable.value(piece: .king, row: 5, col: 5)
        #expect(cornerVal > centerVal)
        #expect(cornerVal == 20)
    }

    @Test("total score for empty board is zero")
    func emptyBoardZeroScore() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let score = PieceSquareTable.totalScore(position: position, player: .attacker)
        #expect(score == 0)
    }

    @Test("total score for starting position is positive")
    func startingPositionPositiveScore() {
        let position = Position.copenhagenStart()
        let atkScore = PieceSquareTable.totalScore(position: position, player: .attacker)
        let defScore = PieceSquareTable.totalScore(position: position, player: .defender)
        #expect(atkScore > 0)
        #expect(defScore > 0)
    }

    @Test("attacker value is non-negative")
    func attackerValueNonNegative() {
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                let val = PieceSquareTable.value(piece: .attacker, row: row, col: col)
                #expect(val >= 0)
            }
        }
    }
}
