import Testing
@testable import Hnefatafl

@Suite("Export Format Tests")
struct ExportFormatTests {

    @Test("PGN format contains move numbers")
    func pgnFormat() {
        let moves = [Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 0)]
        let result = ExportFormat.exportMoves(moves: moves, format: .pgn)
        #expect(result.content.contains("1. "))
        #expect(result.format == .pgn)
    }

    @Test("JSON format is valid bracket structure")
    func jsonFormat() {
        let moves = [Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 0)]
        let result = ExportFormat.exportMoves(moves: moves, format: .json)
        #expect(result.content.hasPrefix("["))
        #expect(result.content.hasSuffix("]"))
    }

    @Test("text format uses arrow notation")
    func textFormat() {
        let moves = [Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 0)]
        let result = ExportFormat.exportMoves(moves: moves, format: .text)
        #expect(result.content.contains("->"))
    }

    @Test("empty moves produce empty content")
    func emptyMoves() {
        let result = ExportFormat.exportMoves(moves: [], format: .pgn)
        #expect(result.content == "")
    }

    @Test("format type is preserved")
    func formatTypePreserved() {
        let result = ExportFormat.exportMoves(moves: [], format: .json)
        #expect(result.format == .json)
    }

    @Test("single move in text format starts with 1")
    func singleMoveText() {
        let moves = [Move(fromRow: 5, fromCol: 5, toRow: 5, toCol: 8)]
        let result = ExportFormat.exportMoves(moves: moves, format: .text)
        #expect(result.content.hasPrefix("1."))
    }
}
