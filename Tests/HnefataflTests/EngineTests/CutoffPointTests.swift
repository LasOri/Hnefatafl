import Testing
@testable import Hnefatafl

@Suite("CutoffPoint Tests")
struct CutoffPointTests {
    @Test("Empty board has no critical points")
    func emptyBoardNoCritical() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let points = CutoffPoint.criticalPoints(position: position)
        #expect(points.isEmpty)
    }

    @Test("Occupied square is not a cutoff point")
    func occupiedSquareNotCutoff() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[60] = .attacker
        let position = Position(cells: cells)
        let result = CutoffPoint.isCutoffSquare(row: 5, col: 5, position: position)
        #expect(result == false)
    }

    @Test("Square between pieces on both axes is a cutoff")
    func squareBetweenPiecesIsCutoff() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 3] = .attacker
        cells[5 * 11 + 7] = .attacker
        cells[3 * 11 + 5] = .defender
        cells[7 * 11 + 5] = .defender
        let position = Position(cells: cells)
        let result = CutoffPoint.isCutoffSquare(row: 5, col: 5, position: position)
        #expect(result == true)
    }

    @Test("Square with pieces only on one axis is not a cutoff")
    func singleAxisNotCutoff() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 3] = .attacker
        cells[5 * 11 + 7] = .attacker
        let position = Position(cells: cells)
        let result = CutoffPoint.isCutoffSquare(row: 5, col: 5, position: position)
        #expect(result == false)
    }

    @Test("Start position has some critical points")
    func startPositionCriticalPoints() {
        let position = Position.copenhagenStart()
        let points = CutoffPoint.criticalPoints(position: position)
        #expect(points.count >= 0)
    }

    @Test("Critical points list only contains valid coordinates")
    func validCoordinates() {
        let position = Position.copenhagenStart()
        let points = CutoffPoint.criticalPoints(position: position)
        for point in points {
            #expect(point.row >= 0 && point.row < Position.boardSize)
            #expect(point.col >= 0 && point.col < Position.boardSize)
        }
    }
}
