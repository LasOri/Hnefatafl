import Testing
@testable import Hnefatafl

@Suite("Piece Cluster Tests")
struct PieceClusterTests {

    @Test("empty board has zero clusters")
    func emptyBoardNoClusters() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let info = PieceCluster.analyze(position: position, player: .attacker)
        #expect(info.count == 0)
        #expect(info.maxSize == 0)
    }

    @Test("single piece forms one cluster of size one")
    func singlePiece() {
        let position = emptyBoard()
            .placing(.attacker, row: 3, col: 3)
            .build()
        let info = PieceCluster.analyze(position: position, player: .attacker)
        #expect(info.count == 1)
        #expect(info.maxSize == 1)
    }

    @Test("two adjacent pieces form one cluster of size two")
    func twoAdjacentPieces() {
        let position = emptyBoard()
            .placing(.attacker, row: 3, col: 3)
            .placing(.attacker, row: 3, col: 4)
            .build()
        let info = PieceCluster.analyze(position: position, player: .attacker)
        #expect(info.count == 1)
        #expect(info.maxSize == 2)
    }

    @Test("two separated pieces form two clusters")
    func twoSeparatedPieces() {
        let position = emptyBoard()
            .placing(.attacker, row: 0, col: 0)
            .placing(.attacker, row: 10, col: 10)
            .build()
        let info = PieceCluster.analyze(position: position, player: .attacker)
        #expect(info.count == 2)
        #expect(info.maxSize == 1)
    }

    @Test("defender cluster includes king")
    func defenderClusterIncludesKing() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.defender, row: 5, col: 6)
            .build()
        let info = PieceCluster.analyze(position: position, player: .defender)
        #expect(info.count == 1)
        #expect(info.maxSize == 2)
    }
}
