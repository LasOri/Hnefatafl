import Testing
@testable import Hnefatafl

@Suite("Game Export Tests")
struct GameExportTests {

    @Test("export empty game returns header only")
    func emptyGame() {
        let game = Game()
        let result = GameExporter.export(game: game)
        #expect(result.contains("[Game \"Hnefatafl\"]"))
        #expect(result.contains("[Variant \"Copenhagen\"]"))
    }

    @Test("export includes date header")
    func dateHeader() {
        let game = Game()
        let result = GameExporter.export(game: game)
        #expect(result.contains("[Date"))
    }

    @Test("export includes moves after header")
    func movesAfterHeader() {
        var game = Game()
        let move = game.position.allLegalMoves(for: .attacker).first!
        game = game.makeMove(move)
        let result = GameExporter.export(game: game)
        let lines = result.split(separator: "\n")
        let headerEnd = lines.lastIndex(where: { $0.hasPrefix("[") })!
        #expect(lines.count > headerEnd + 1)
    }

    @Test("export formats moves as algebraic pairs")
    func algebraicPairs() {
        var game = Game()
        let move1 = game.position.allLegalMoves(for: .attacker).first!
        game = game.makeMove(move1)
        let move2 = game.position.allLegalMoves(for: .defender).first!
        game = game.makeMove(move2)
        let result = GameExporter.export(game: game)
        #expect(result.contains("1."))
    }

    @Test("export result for in-progress game")
    func inProgressResult() {
        let game = Game()
        let result = GameExporter.export(game: game)
        #expect(result.contains("[Result \"*\"]"))
    }

    @Test("export result for attacker win")
    func attackerWinResult() {
        let result = GameExporter.resultString(for: .attackerWins)
        #expect(result == "1-0")
    }

    @Test("export result for defender win")
    func defenderWinResult() {
        let result = GameExporter.resultString(for: .defenderWins)
        #expect(result == "0-1")
    }

    @Test("export result for draw")
    func drawResult() {
        let result = GameExporter.resultString(for: .draw)
        #expect(result == "1/2-1/2")
    }

    @Test("import parses header tags")
    func importHeaders() {
        let pgn = """
        [Game "Hnefatafl"]
        [Variant "Copenhagen"]
        [Result "*"]
        """
        let headers = GameImporter.parseHeaders(pgn)
        #expect(headers["Game"] == "Hnefatafl")
        #expect(headers["Variant"] == "Copenhagen")
    }

    @Test("import parses move text")
    func importMoveText() {
        let pgn = """
        [Game "Hnefatafl"]

        1. D1-D3 F6-F8
        """
        let moveText = GameImporter.parseMoveText(pgn)
        #expect(moveText.contains("D1-D3"))
    }
}
