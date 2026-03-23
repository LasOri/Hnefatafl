import Testing
@testable import Hnefatafl

@Suite("Position Tests")
struct PositionTests {

    @Test("empty board has 121 cells")
    func emptyBoard_has121Cells() {
        let position = Position()

        #expect(position.cells.count == 121)
    }

    @Test("top-left corner is a corner square")
    func squareType_topLeftCorner_isCorner() {
        #expect(Position.squareType(row: 0, col: 0) == .corner)
    }

    @Test("center square is the throne")
    func squareType_center_isThrone() {
        #expect(Position.squareType(row: 5, col: 5) == .throne)
    }

    @Test("middle of board is a regular square")
    func squareType_regularSquare_isRegular() {
        #expect(Position.squareType(row: 3, col: 3) == .regular)
    }

    @Test("empty board has no piece at any position")
    func pieceAt_emptyBoard_returnsNil() {
        let position = Position()

        #expect(position.pieceAt(row: 5, col: 5) == nil)
    }

    @Test("Copenhagen start has king at center")
    func copenhagenStart_kingAtCenter() {
        let position = Position.copenhagenStart()

        #expect(position.pieceAt(row: 5, col: 5) == .king)
    }

    @Test("Copenhagen start has 24 attackers, 12 defenders, 1 king")
    func copenhagenStart_correctPieceCounts() {
        let position = Position.copenhagenStart()

        let attackers = position.cells.filter { $0 == .attacker }.count
        let defenders = position.cells.filter { $0 == .defender }.count
        let kings = position.cells.filter { $0 == .king }.count

        #expect(attackers == 24)
        #expect(defenders == 12)
        #expect(kings == 1)
    }
}
