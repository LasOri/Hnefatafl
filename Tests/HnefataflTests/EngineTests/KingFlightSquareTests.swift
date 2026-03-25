import Testing
@testable import Hnefatafl

@Suite("King Flight Square Tests")
struct KingFlightSquareTests {

    @Test("king with no attackers has many flight squares")
    func noAttackers() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 3] = .king
        let position = Position(cells: cells)
        #expect(KingFlightSquare.flightSquareCount(position: position) > 0)
    }

    @Test("king surrounded by attackers in all directions has no flight squares")
    func fullySurrounded() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[5 * 11 + 3] = .attacker
        cells[5 * 11 + 7] = .attacker
        cells[3 * 11 + 5] = .attacker
        cells[7 * 11 + 5] = .attacker
        let position = Position(cells: cells)
        #expect(KingFlightSquare.flightSquareCount(position: position) == 0)
    }

    @Test("flight squares returns tuples with valid coordinates")
    func validCoordinates() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[3 * 11 + 3] = .king
        let position = Position(cells: cells)
        let squares = KingFlightSquare.flightSquares(position: position)
        for sq in squares {
            #expect(sq.row >= 0 && sq.row < 11)
            #expect(sq.col >= 0 && sq.col < 11)
        }
    }

    @Test("returns empty when no king on board")
    func noKing() {
        let cells: [Piece?] = Array(repeating: nil, count: 121)
        let position = Position(cells: cells)
        #expect(KingFlightSquare.flightSquareCount(position: position) == 0)
    }

    @Test("count matches array length")
    func countMatchesArray() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[3 * 11 + 3] = .king
        let position = Position(cells: cells)
        let squares = KingFlightSquare.flightSquares(position: position)
        #expect(squares.count == KingFlightSquare.flightSquareCount(position: position))
    }

    @Test("attacker on same row blocks flight along that line")
    func attackerBlocksLine() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[4 * 11 + 2] = .king
        cells[4 * 11 + 8] = .attacker
        let position = Position(cells: cells)
        let squares = KingFlightSquare.flightSquares(position: position)
        let rightSquares = squares.filter { $0.row == 4 && $0.col > 2 }
        #expect(rightSquares.isEmpty)
    }
}
