import Testing
@testable import Hnefatafl

@Suite("PieceGrouping Tests")
struct PieceGroupingTests {

    @Test("single piece forms one group")
    func singlePiece() {
        let pos = PositionBuilder()
            .place(.attacker, row: 5, col: 5)
            .place(.king, row: 0, col: 0)
            .build()
        let groups = PieceGrouping.find(position: pos, for: .attacker)
        #expect(groups.count == 1)
        #expect(groups[0].size == 1)
    }

    @Test("adjacent pieces form one group")
    func adjacentPieces() {
        let pos = PositionBuilder()
            .place(.attacker, row: 5, col: 5)
            .place(.attacker, row: 5, col: 6)
            .place(.king, row: 0, col: 0)
            .build()
        let groups = PieceGrouping.find(position: pos, for: .attacker)
        #expect(groups.count == 1)
        #expect(groups[0].size == 2)
    }

    @Test("separated pieces form separate groups")
    func separatedPieces() {
        let pos = PositionBuilder()
            .place(.attacker, row: 0, col: 0)
            .place(.attacker, row: 10, col: 10)
            .place(.king, row: 5, col: 5)
            .build()
        let groups = PieceGrouping.find(position: pos, for: .attacker)
        #expect(groups.count == 2)
    }

    @Test("PieceGroup is Equatable")
    func equatable() {
        let a = PieceGroup(squares: [(0, 0)], size: 1)
        let b = PieceGroup(squares: [(0, 0)], size: 1)
        #expect(a == b)
    }

    @Test("empty board has no groups")
    func emptyBoard() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let groups = PieceGrouping.find(position: pos, for: .attacker)
        #expect(groups.isEmpty)
    }

    @Test("starting position has attacker groups")
    func startingPosition() {
        let pos = Position.copenhagenStart()
        let groups = PieceGrouping.find(position: pos, for: .attacker)
        #expect(!groups.isEmpty)
    }
}
