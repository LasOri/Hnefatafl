import Testing
@testable import Hnefatafl

@Suite("PositionClassifier Tests")
struct PositionClassifierTests {
    @Test("Empty board classifies as endgame (zero pieces)")
    func emptyBoardEndgame() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let result = PositionClassifier.classify(position: position)
        #expect(result == .endgame)
    }

    @Test("Few pieces classifies as endgame")
    func fewPiecesEndgame() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 0, col: 0)
            .placing(.attacker, row: 10, col: 10)
            .build()
        let result = PositionClassifier.classify(position: position)
        #expect(result == .endgame)
    }

    @Test("PositionClass conforms to CaseIterable")
    func caseIterable() {
        #expect(PositionClass.allCases.count == 4)
    }

    @Test("PositionClass raw values are correct")
    func rawValues() {
        #expect(PositionClass.quiet.rawValue == "quiet")
        #expect(PositionClass.tactical.rawValue == "tactical")
        #expect(PositionClass.sharp.rawValue == "sharp")
        #expect(PositionClass.endgame.rawValue == "endgame")
    }

    @Test("Classify returns a valid PositionClass")
    func returnsValidClass() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.defender, row: 4, col: 5)
            .placing(.defender, row: 6, col: 5)
            .placing(.defender, row: 5, col: 4)
            .placing(.defender, row: 5, col: 6)
            .placing(.attacker, row: 3, col: 5)
            .placing(.attacker, row: 7, col: 5)
            .placing(.attacker, row: 5, col: 3)
            .placing(.attacker, row: 5, col: 7)
            .build()
        let result = PositionClassifier.classify(position: position)
        #expect(PositionClass.allCases.contains(result))
    }

    @Test("Many adjacent enemies yields tactical or sharp")
    func manyAdjacentEnemies() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.defender, row: 4, col: 5)
            .placing(.defender, row: 6, col: 5)
            .placing(.defender, row: 5, col: 4)
            .placing(.defender, row: 5, col: 6)
            .placing(.attacker, row: 3, col: 5)
            .placing(.attacker, row: 4, col: 4)
            .placing(.attacker, row: 4, col: 6)
            .placing(.attacker, row: 7, col: 5)
            .placing(.attacker, row: 6, col: 4)
            .placing(.attacker, row: 6, col: 6)
            .build()
        let result = PositionClassifier.classify(position: position)
        #expect(result == .tactical || result == .sharp)
    }
}
