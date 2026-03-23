import Testing
@testable import Hnefatafl

@Suite("King Capture Tests")
struct KingCaptureTests {

    @Test("king away from throne captured by 2 attackers (custodial)")
    func applyMove_kingCustodialCapture_removesKing() {
        let position = emptyBoard()
            .placing(.king, row: 3, col: 5)
            .placing(.attacker, row: 3, col: 4)
            .placing(.attacker, row: 3, col: 7)
            .build()
        let move = Move(fromRow: 3, fromCol: 7, toRow: 3, toCol: 6)

        let result = position.applyMove(move)

        #expect(result.pieceAt(row: 3, col: 5) == nil)
    }

    @Test("king on throne survives 3 attackers")
    func applyMove_kingOnThrone3Attackers_survives() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 4, col: 5)
            .placing(.attacker, row: 6, col: 5)
            .placing(.attacker, row: 5, col: 8)
            .build()
        let move = Move(fromRow: 5, fromCol: 8, toRow: 5, toCol: 6)

        let result = position.applyMove(move)

        #expect(result.pieceAt(row: 5, col: 5) == .king)
    }

    @Test("king on throne captured by 4 attackers")
    func applyMove_kingOnThrone4Attackers_captured() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 4, col: 5)
            .placing(.attacker, row: 6, col: 5)
            .placing(.attacker, row: 5, col: 4)
            .placing(.attacker, row: 5, col: 8)
            .build()
        let move = Move(fromRow: 5, fromCol: 8, toRow: 5, toCol: 6)

        let result = position.applyMove(move)

        #expect(result.pieceAt(row: 5, col: 5) == nil)
    }

    @Test("king adjacent to throne captured by 3 attackers + throne")
    func applyMove_kingAdjacentThrone3Attackers_captured() {
        let position = emptyBoard()
            .placing(.king, row: 4, col: 5)
            .placing(.attacker, row: 3, col: 5)
            .placing(.attacker, row: 4, col: 4)
            .placing(.attacker, row: 4, col: 7)
            .build()
        let move = Move(fromRow: 4, fromCol: 7, toRow: 4, toCol: 6)

        let result = position.applyMove(move)

        #expect(result.pieceAt(row: 4, col: 5) == nil)
    }

    @Test("king not captured with only 1 attacker")
    func applyMove_king1Attacker_survives() {
        let position = emptyBoard()
            .placing(.king, row: 3, col: 5)
            .placing(.attacker, row: 3, col: 7)
            .build()
        let move = Move(fromRow: 3, fromCol: 7, toRow: 3, toCol: 6)

        let result = position.applyMove(move)

        #expect(result.pieceAt(row: 3, col: 5) == .king)
    }
}
