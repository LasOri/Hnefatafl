import Testing
@testable import Hnefatafl

@Suite("King Escape Path BFS Tests")
struct KingEscapePathBFSTests {

    @Test("no king returns nil for shortest path")
    func noKingReturnsNil() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(KingEscapePath.shortestPathLength(position: position) == nil)
    }

    @Test("king at corner has zero path length")
    func kingAtCornerZeroLength() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .king
        let position = Position(cells: cells)
        #expect(KingEscapePath.shortestPathLength(position: position) == 0)
    }

    @Test("king adjacent to corner has path length 1")
    func kingAdjacentToCorner() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 1] = .king
        let position = Position(cells: cells)
        let length = KingEscapePath.shortestPathLength(position: position)
        #expect(length == 1)
    }

    @Test("hasEscapeRoute returns true when path exists")
    func hasEscapeRouteTrue() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 1] = .king
        let position = Position(cells: cells)
        #expect(KingEscapePath.hasEscapeRoute(position: position) == true)
    }

    @Test("hasEscapeRoute returns false when no king")
    func hasEscapeRouteFalseNoKing() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(KingEscapePath.hasEscapeRoute(position: position) == false)
    }

    @Test("king with open line to corner has escape")
    func kingWithOpenLineToCorner() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 3] = .king
        let position = Position(cells: cells)
        let hasRoute = KingEscapePath.hasEscapeRoute(position: position)
        #expect(hasRoute == true)
    }

    @Test("shortest path through multiple moves")
    func shortestPathMultipleMoves() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[2 * 11 + 3] = .king
        let position = Position(cells: cells)
        let length = KingEscapePath.shortestPathLength(position: position)
        #expect(length != nil)
        if let length { #expect(length >= 1) }
    }
}
