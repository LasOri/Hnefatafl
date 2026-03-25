import Testing
@testable import Hnefatafl

@Suite("HnefataflPGN Tests")
struct HnefataflPGNTests {

    @Test("PGN struct stores headers and moves")
    func structStoresData() {
        let pgn = HnefataflPGN(
            headers: ["Event": "Casual", "Date": "2026.03.25"],
            moves: ["d1-d5", "f6-f3"]
        )
        #expect(pgn.headers["Event"] == "Casual")
        #expect(pgn.moves.count == 2)
    }

    @Test("export includes header lines")
    func exportHeaders() {
        let game = Game()
        let text = HnefataflPGN.export(game: game, headers: ["Event": "Test"])
        #expect(text.contains("[Event \"Test\"]"))
    }

    @Test("export includes Date header")
    func exportDate() {
        let game = Game()
        let text = HnefataflPGN.export(game: game, headers: ["Date": "2026.03.25"])
        #expect(text.contains("[Date \"2026.03.25\"]"))
    }

    @Test("export includes Result header")
    func exportResult() {
        let game = Game()
        let text = HnefataflPGN.export(game: game)
        #expect(text.contains("[Result"))
    }

    @Test("export includes Variant header")
    func exportVariant() {
        let game = Game()
        let text = HnefataflPGN.export(game: game)
        #expect(text.contains("[Variant \"Copenhagen\"]"))
    }

    @Test("in-progress result is asterisk")
    func inProgressResult() {
        let game = Game()
        let text = HnefataflPGN.export(game: game)
        #expect(text.contains("[Result \"*\"]"))
    }

    @Test("export with moves includes numbered move list")
    func numberedMoves() {
        let game = Game()
        let move = game.position.allLegalMoves(for: .attacker).first!
        let after1 = game.makeMove(move)
        let defMove = after1.position.allLegalMoves(for: .defender).first!
        let after2 = after1.makeMove(defMove)
        let text = HnefataflPGN.export(game: after2)
        #expect(text.contains("1."))
    }

    @Test("parse PGN string extracts headers")
    func parseHeaders() {
        let text = "[Event \"Test\"]\n[Date \"2026.03.25\"]\n\n"
        let pgn = HnefataflPGN.parse(text)
        #expect(pgn != nil)
        #expect(pgn?.headers["Event"] == "Test")
        #expect(pgn?.headers["Date"] == "2026.03.25")
    }

    @Test("parse PGN string extracts moves")
    func parseMoves() {
        let text = "[Event \"Test\"]\n\n1. d4-d8 f6-f3\n"
        let pgn = HnefataflPGN.parse(text)
        #expect(pgn?.moves.count == 2)
        #expect(pgn?.moves[0] == "d4-d8")
        #expect(pgn?.moves[1] == "f6-f3")
    }

    @Test("parse empty string returns nil")
    func parseEmpty() {
        #expect(HnefataflPGN.parse("") == nil)
    }

    @Test("round trip export then parse preserves headers")
    func roundTripHeaders() {
        let game = Game()
        let text = HnefataflPGN.export(game: game, headers: ["Event": "Round Trip"])
        let pgn = HnefataflPGN.parse(text)
        #expect(pgn?.headers["Event"] == "Round Trip")
    }

    @Test("round trip preserves move count")
    func roundTripMoves() {
        let game = Game()
        let move = game.position.allLegalMoves(for: .attacker).first!
        let after = game.makeMove(move)
        let text = HnefataflPGN.export(game: after)
        let pgn = HnefataflPGN.parse(text)
        #expect(pgn?.moves.count == 1)
    }

    @Test("PGN is Equatable")
    func equatable() {
        let a = HnefataflPGN(headers: ["Event": "A"], moves: ["d1-d5"])
        let b = HnefataflPGN(headers: ["Event": "A"], moves: ["d1-d5"])
        #expect(a == b)
    }
}
