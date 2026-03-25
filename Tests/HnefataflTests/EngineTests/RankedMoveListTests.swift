import Testing
@testable import Hnefatafl

@Suite("Ranked Move List Tests")
struct RankedMoveListTests {

    @Test("rank returns same count as input moves")
    func rankPreservesCount() {
        let pos = Position.copenhagenStart()
        let moves = pos.allLegalMoves(for: .attacker)
        let ranked = RankedMoveList.rank(moves: moves, position: pos, player: .attacker)
        #expect(ranked.count == moves.count)
    }

    @Test("ranked list is sorted by descending score")
    func rankedSorted() {
        let pos = Position.copenhagenStart()
        let moves = pos.allLegalMoves(for: .attacker)
        let ranked = RankedMoveList.rank(moves: moves, position: pos, player: .attacker)
        for i in 0..<ranked.count - 1 {
            #expect(ranked[i].score >= ranked[i + 1].score)
        }
    }

    @Test("topMoves returns requested count")
    func topMovesCount() {
        let pos = Position.copenhagenStart()
        let top = RankedMoveList.topMoves(position: pos, player: .attacker, count: 3)
        #expect(top.count == 3)
    }

    @Test("topMoves returns at most available moves")
    func topMovesClamp() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .attacker
        let pos = Position(cells: cells)
        let top = RankedMoveList.topMoves(position: pos, player: .attacker, count: 100)
        #expect(top.count <= 100)
    }

    @Test("empty moves returns empty ranking")
    func emptyMoves() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let ranked = RankedMoveList.rank(moves: [], position: pos, player: .attacker)
        #expect(ranked.isEmpty)
    }

    @Test("defender top moves are valid legal moves")
    func defenderTopMovesLegal() {
        let pos = Position.copenhagenStart()
        let allMoves = pos.allLegalMoves(for: .defender)
        let top = RankedMoveList.topMoves(position: pos, player: .defender, count: 5)
        for move in top {
            #expect(allMoves.contains(move))
        }
    }
}
