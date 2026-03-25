import Testing
@testable import Hnefatafl

@Suite("PieceFormationShape Tests")
struct PieceFormationShapeTests {
    @Test("Empty board classifies as scattered for attacker")
    func emptyBoardScattered() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let shape = PieceFormationShape.classify(position: position, player: .attacker)
        #expect(shape == .scattered)
    }

    @Test("Single piece classifies as scattered")
    func singlePieceScattered() {
        let position = emptyBoard()
            .placing(.attacker, row: 5, col: 5)
            .build()
        let shape = PieceFormationShape.classify(position: position, player: .attacker)
        #expect(shape == .scattered)
    }

    @Test("Pieces in same row classify as line")
    func horizontalLine() {
        let position = emptyBoard()
            .placing(.attacker, row: 3, col: 2)
            .placing(.attacker, row: 3, col: 3)
            .placing(.attacker, row: 3, col: 4)
            .build()
        let shape = PieceFormationShape.classify(position: position, player: .attacker)
        #expect(shape == .line)
    }

    @Test("Pieces in same column classify as line")
    func verticalLine() {
        let position = emptyBoard()
            .placing(.defender, row: 1, col: 5)
            .placing(.defender, row: 2, col: 5)
            .placing(.defender, row: 3, col: 5)
            .build()
        let shape = PieceFormationShape.classify(position: position, player: .defender)
        #expect(shape == .line)
    }

    @Test("Adjacent pieces classify as cluster")
    func clusterFormation() {
        let position = emptyBoard()
            .placing(.attacker, row: 5, col: 5)
            .placing(.attacker, row: 5, col: 6)
            .placing(.attacker, row: 6, col: 5)
            .build()
        let shape = PieceFormationShape.classify(position: position, player: .attacker)
        #expect(shape == .cluster)
    }

    @Test("FormationShape conforms to CaseIterable")
    func caseIterable() {
        #expect(FormationShape.allCases.count == 4)
    }

    @Test("FormationShape raw values are correct")
    func rawValues() {
        #expect(FormationShape.line.rawValue == "line")
        #expect(FormationShape.cluster.rawValue == "cluster")
        #expect(FormationShape.arc.rawValue == "arc")
        #expect(FormationShape.scattered.rawValue == "scattered")
    }
}
