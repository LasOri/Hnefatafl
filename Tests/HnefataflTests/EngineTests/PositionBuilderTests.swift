import Testing
@testable import Hnefatafl

@Suite("PositionBuilder Tests")
struct PositionBuilderTests {

    @Test("empty builder produces empty board")
    func emptyBoard() {
        let position = PositionBuilder().build()
        for row in 0..<11 {
            for col in 0..<11 {
                #expect(position.pieceAt(row: row, col: col) == nil)
            }
        }
    }

    @Test("place king at center")
    func placeKing() {
        let position = PositionBuilder()
            .place(.king, row: 5, col: 5)
            .build()
        #expect(position.pieceAt(row: 5, col: 5) == .king)
    }

    @Test("place multiple pieces")
    func placeMultiple() {
        let position = PositionBuilder()
            .place(.king, row: 5, col: 5)
            .place(.attacker, row: 0, col: 3)
            .place(.defender, row: 4, col: 5)
            .build()
        #expect(position.pieceAt(row: 5, col: 5) == .king)
        #expect(position.pieceAt(row: 0, col: 3) == .attacker)
        #expect(position.pieceAt(row: 4, col: 5) == .defender)
    }

    @Test("chaining is fluent")
    func fluent() {
        let builder = PositionBuilder()
            .place(.king, row: 0, col: 0)
            .place(.attacker, row: 1, col: 1)
        #expect(builder.build().pieceAt(row: 0, col: 0) == .king)
    }

    @Test("clear removes all pieces")
    func clear() {
        let position = PositionBuilder()
            .place(.king, row: 5, col: 5)
            .clear()
            .build()
        #expect(position.pieceAt(row: 5, col: 5) == nil)
    }

    @Test("remove specific piece")
    func removePiece() {
        let position = PositionBuilder()
            .place(.king, row: 5, col: 5)
            .place(.attacker, row: 0, col: 0)
            .remove(row: 0, col: 0)
            .build()
        #expect(position.pieceAt(row: 5, col: 5) == .king)
        #expect(position.pieceAt(row: 0, col: 0) == nil)
    }

    @Test("from existing position")
    func fromExisting() {
        let start = Position.copenhagenStart()
        let position = PositionBuilder(from: start)
            .remove(row: 5, col: 5)
            .build()
        #expect(position.pieceAt(row: 5, col: 5) == nil)
        #expect(position.pieceAt(row: 0, col: 3) != nil)
    }

    @Test("place row of attackers")
    func placeRow() {
        let position = PositionBuilder()
            .placeRow(.attacker, row: 0, cols: [3, 4, 5, 6, 7])
            .place(.king, row: 5, col: 5)
            .build()
        #expect(position.pieceAt(row: 0, col: 3) == .attacker)
        #expect(position.pieceAt(row: 0, col: 7) == .attacker)
    }

    @Test("pieceCount returns correct count")
    func pieceCount() {
        let builder = PositionBuilder()
            .place(.king, row: 5, col: 5)
            .place(.attacker, row: 0, col: 0)
            .place(.attacker, row: 1, col: 1)
        #expect(builder.pieceCount == 3)
    }
}
