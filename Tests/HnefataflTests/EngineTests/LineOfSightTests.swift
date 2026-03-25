import Testing
@testable import Hnefatafl

@Suite("Line of Sight Tests")
struct LineOfSightTests {

    @Test("clear line on empty board")
    func clearLine() {
        let cells: [Piece?] = Array(repeating: nil, count: 121)
        let position = Position(cells: cells)
        #expect(LineOfSight.isClear(from: (0, 0), to: (0, 10), position: position))
    }

    @Test("blocked line")
    func blockedLine() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5] = .attacker
        let position = Position(cells: cells)
        #expect(!LineOfSight.isClear(from: (0, 0), to: (0, 10), position: position))
    }

    @Test("same square is clear")
    func sameSquare() {
        let position = Position.copenhagenStart()
        #expect(LineOfSight.isClear(from: (5, 5), to: (5, 5), position: position))
    }

    @Test("diagonal returns false")
    func diagonal() {
        let cells: [Piece?] = Array(repeating: nil, count: 121)
        let position = Position(cells: cells)
        #expect(!LineOfSight.isClear(from: (0, 0), to: (3, 3), position: position))
    }

    @Test("vertical line clear")
    func verticalClear() {
        let cells: [Piece?] = Array(repeating: nil, count: 121)
        let position = Position(cells: cells)
        #expect(LineOfSight.isClear(from: (0, 5), to: (10, 5), position: position))
    }

    @Test("vertical line blocked")
    func verticalBlocked() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        let position = Position(cells: cells)
        #expect(!LineOfSight.isClear(from: (0, 5), to: (10, 5), position: position))
    }

    @Test("squares between horizontal")
    func squaresBetween() {
        let squares = LineOfSight.squaresBetween(from: (0, 0), to: (0, 5))
        #expect(squares.count == 4)
    }

    @Test("squares between vertical")
    func squaresBetweenVertical() {
        let squares = LineOfSight.squaresBetween(from: (2, 3), to: (6, 3))
        #expect(squares.count == 3)
    }
}
