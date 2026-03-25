import Testing
@testable import Hnefatafl

@Suite("Opening Classifier Tests")
struct OpeningClassifierTests {

    @Test("empty moves returns standard")
    func emptyMovesStandard() {
        #expect(OpeningClassifier.classify(moves: []) == .standard)
    }

    @Test("fewer than 4 moves returns unknown")
    func fewMovesUnknown() {
        let moves = [
            Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 5),
            Move(fromRow: 5, fromCol: 4, toRow: 3, toCol: 4),
        ]
        #expect(OpeningClassifier.classify(moves: moves) == .unknown)
    }

    @Test("center move is aggressive")
    func centerMoveAggressive() {
        let moves = [
            Move(fromRow: 0, fromCol: 3, toRow: 4, toCol: 3),
            Move(fromRow: 5, fromCol: 4, toRow: 3, toCol: 4),
            Move(fromRow: 3, fromCol: 0, toRow: 3, toCol: 2),
            Move(fromRow: 5, fromCol: 6, toRow: 3, toCol: 6),
        ]
        #expect(OpeningClassifier.classify(moves: moves) == .aggressive)
    }

    @Test("edge move is defensive")
    func edgeMoveDefensive() {
        let moves = [
            Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 10),
            Move(fromRow: 5, fromCol: 4, toRow: 3, toCol: 4),
            Move(fromRow: 3, fromCol: 0, toRow: 3, toCol: 2),
            Move(fromRow: 5, fromCol: 6, toRow: 3, toCol: 6),
        ]
        #expect(OpeningClassifier.classify(moves: moves) == .defensive)
    }

    @Test("standard for mid-range distance")
    func standardMidRange() {
        let moves = [
            Move(fromRow: 0, fromCol: 3, toRow: 2, toCol: 3),
            Move(fromRow: 5, fromCol: 4, toRow: 3, toCol: 4),
            Move(fromRow: 3, fromCol: 0, toRow: 3, toCol: 2),
            Move(fromRow: 5, fromCol: 6, toRow: 3, toCol: 6),
        ]
        #expect(OpeningClassifier.classify(moves: moves) == .standard)
    }
}
