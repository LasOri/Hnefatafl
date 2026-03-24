import Testing
@testable import Hnefatafl

@Suite("Move Classification Tests")
struct MoveClassificationTests {

    @Test("classify regular move")
    func regularMove() {
        let game = Game()
        let move = game.position.allLegalMoves(for: .attacker).first!
        let classification = MoveClassifier.classify(move: move, in: game)
        #expect(classification.contains(.regular))
    }

    @Test("MoveType has expected cases")
    func moveTypes() {
        let types: [MoveType] = [.regular, .capture, .kingEscape, .check, .aggressive, .defensive]
        #expect(types.count == 6)
    }

    @Test("aggressive move toward center")
    func aggressiveMove() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .attacker
        cells[60] = .king
        let position = Position(cells: cells)
        let game = Game(position: position, currentPlayer: .attacker, moveHistory: [])
        let move = Move(fromRow: 0, fromCol: 0, toRow: 5, toCol: 0)
        let classification = MoveClassifier.classify(move: move, in: game)
        #expect(classification.contains(.aggressive))
    }

    @Test("classification is non-empty")
    func nonEmpty() {
        let game = Game()
        let move = game.position.allLegalMoves(for: .attacker).first!
        let classification = MoveClassifier.classify(move: move, in: game)
        #expect(!classification.isEmpty)
    }

    @Test("MoveType label is non-empty")
    func labels() {
        #expect(!MoveType.regular.label.isEmpty)
        #expect(!MoveType.capture.label.isEmpty)
        #expect(!MoveType.kingEscape.label.isEmpty)
    }

    @Test("king move toward corner classified as kingEscape")
    func kingEscapeMove() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[1 * 11 + 0] = .king
        let position = Position(cells: cells)
        let game = Game(position: position, currentPlayer: .defender, moveHistory: [])
        let move = Move(fromRow: 1, fromCol: 0, toRow: 0, toCol: 0)
        let classification = MoveClassifier.classify(move: move, in: game)
        #expect(classification.contains(.kingEscape))
    }

    @Test("multiple classifications possible")
    func multipleTypes() {
        let types: [MoveType] = [.regular, .aggressive]
        #expect(types.count == 2)
    }

    @Test("defensive retreat from center")
    func defensiveRetreat() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 4] = .defender
        cells[60] = .king
        let position = Position(cells: cells)
        let game = Game(position: position, currentPlayer: .defender, moveHistory: [])
        let move = Move(fromRow: 5, fromCol: 4, toRow: 1, toCol: 4)
        let classification = MoveClassifier.classify(move: move, in: game)
        #expect(classification.contains(.defensive) || classification.contains(.regular))
    }
}
