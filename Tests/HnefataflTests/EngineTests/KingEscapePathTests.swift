import Testing
@testable import Hnefatafl

@Suite("King Escape Path Tests")
struct KingEscapePathTests {

    @Test("starting position has no immediate escape")
    func noImmediateEscape() {
        let position = Position.copenhagenStart()
        let paths = KingEscapePath.findPaths(position: position, maxDepth: 1)
        #expect(paths.isEmpty)
    }

    @Test("king at corner adjacent has 1-move path")
    func cornerAdjacent() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[1] = .king
        let position = Position(cells: cells)
        let paths = KingEscapePath.findPaths(position: position, maxDepth: 1)
        #expect(!paths.isEmpty)
    }

    @Test("EscapePath has moves and length")
    func escapePathProperties() {
        let move = Move(fromRow: 0, fromCol: 1, toRow: 0, toCol: 0)
        let path = EscapePath(moves: [move])
        #expect(path.length == 1)
        #expect(path.moves.first == move)
    }

    @Test("shortest path first")
    func shortestFirst() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[1] = .king
        let position = Position(cells: cells)
        let paths = KingEscapePath.findPaths(position: position, maxDepth: 3)
        if paths.count >= 2 {
            #expect(paths[0].length <= paths[1].length)
        }
    }

    @Test("no path when blocked")
    func noPathBlocked() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[55] = .king
        for i in 0..<11 { cells[i] = .attacker }
        for i in 110..<121 { cells[i] = .attacker }
        for row in 1..<10 {
            cells[row * 11] = .attacker
            cells[row * 11 + 10] = .attacker
        }
        let position = Position(cells: cells)
        let paths = KingEscapePath.findPaths(position: position, maxDepth: 1)
        #expect(paths.isEmpty)
    }

    @Test("EscapePath is Equatable")
    func equatable() {
        let a = EscapePath(moves: [])
        let b = EscapePath(moves: [])
        #expect(a == b)
    }
}
