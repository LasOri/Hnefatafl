import Testing
@testable import Hnefatafl

@Suite("GameNotation Tests")
struct GameNotationTests {

    @Test("export empty game returns empty array")
    func exportEmpty() {
        let game = Game()
        let notation = GameNotation.exportMoves(game)
        #expect(notation.isEmpty)
    }

    @Test("export game with one move")
    func exportOneMove() {
        let game = Game()
        let moves = game.position.allLegalMoves(for: .attacker)
        let move = moves.first!
        let afterMove = game.makeMove(move)
        let notation = GameNotation.exportMoves(afterMove)
        #expect(notation.count == 1)
        #expect(!notation[0].isEmpty)
    }

    @Test("export format matches algebraic notation")
    func exportFormat() {
        let move = Move(fromRow: 10, fromCol: 3, toRow: 5, toCol: 3)
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[10 * 11 + 3] = .attacker
        let position = Position(cells: cells)
        let game = Game(position: position, currentPlayer: .attacker, moveHistory: [])
        let afterMove = game.makeMove(move)
        let notation = GameNotation.exportMoves(afterMove)
        #expect(notation[0] == "d1-d6")
    }

    @Test("import single move")
    func importSingle() {
        let start = Position.copenhagenStart()
        let firstMove = start.allLegalMoves(for: .attacker).first!
        let notation = AlgebraicNotation.formatMove(firstMove)
        let result = GameNotation.importMoves([notation], startingPosition: start)
        #expect(result != nil)
        #expect(result?.moveHistory.count == 1)
    }

    @Test("import invalid move returns nil")
    func importInvalid() {
        let result = GameNotation.importMoves(["z99-z88"], startingPosition: Position.copenhagenStart())
        #expect(result == nil)
    }

    @Test("import empty array returns starting game")
    func importEmpty() {
        let result = GameNotation.importMoves([], startingPosition: Position.copenhagenStart())
        #expect(result != nil)
        #expect(result?.moveHistory.count == 0)
    }

    @Test("round trip export then import preserves move count")
    func roundTripMoveCount() {
        let game = Game()
        let moves = game.position.allLegalMoves(for: .attacker)
        let move = moves.first!
        let afterMove = game.makeMove(move)
        let notation = GameNotation.exportMoves(afterMove)
        let imported = GameNotation.importMoves(notation, startingPosition: Position.copenhagenStart())
        #expect(imported?.moveHistory.count == afterMove.moveHistory.count)
    }

    @Test("export full game string")
    func exportFullString() {
        let game = Game()
        let moves = game.position.allLegalMoves(for: .attacker)
        let afterMove = game.makeMove(moves.first!)
        let text = GameNotation.exportToString(afterMove)
        #expect(text.contains("-"))
    }

    @Test("import from string")
    func importFromString() {
        let game = Game()
        let moves = game.position.allLegalMoves(for: .attacker)
        let afterMove = game.makeMove(moves.first!)
        let text = GameNotation.exportToString(afterMove)
        let imported = GameNotation.importFromString(text, startingPosition: Position.copenhagenStart())
        #expect(imported != nil)
        #expect(imported?.moveHistory.count == 1)
    }
}
