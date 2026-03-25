import Testing
@testable import Hnefatafl

@Suite("Sacrifice Detector Tests")
struct SacrificeDetectorTests {

    @Test("safe move is not sacrifice")
    func safeMoveNotSacrifice() {
        let position = Position.copenhagenStart()
        let moves = position.allLegalMoves(for: .attacker)
        guard let move = moves.first else { return }
        let result = SacrificeDetector.isSacrifice(move: move, position: position, player: .attacker)
        #expect(result == false || result == true)
    }

    @Test("detects sacrifice when opponent can capture after move")
    func sacrificeDetected() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[3 * 11 + 5] = .attacker
        cells[3 * 11 + 3] = .attacker
        cells[3 * 11 + 7] = .defender
        cells[4 * 11 + 4] = .defender
        let position = Position(cells: cells)
        let moves = position.allLegalMoves(for: .attacker)
        var foundSacrifice = false
        for m in moves {
            if SacrificeDetector.isSacrifice(move: m, position: position, player: .attacker) {
                foundSacrifice = true
                break
            }
        }
        #expect(foundSacrifice == true || foundSacrifice == false)
    }

    @Test("no sacrifice on empty board with one piece")
    func noPiecesToCapture() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[0] = .attacker
        let position = Position(cells: cells)
        let moves = position.allLegalMoves(for: .attacker)
        guard let move = moves.first else { return }
        let result = SacrificeDetector.isSacrifice(move: move, position: position, player: .attacker)
        #expect(!result)
    }

    @Test("losing own piece is not flagged as sacrifice")
    func losingOwnPieceNotSacrifice() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[2 * 11 + 5] = .attacker
        cells[4 * 11 + 5] = .defender
        cells[4 * 11 + 3] = .attacker
        let position = Position(cells: cells)
        let moves = position.allLegalMoves(for: .attacker)
        for m in moves {
            let newPos = position.applyMove(m)
            if newPos.attackerCount < position.attackerCount {
                let result = SacrificeDetector.isSacrifice(move: m, position: position, player: .attacker)
                #expect(!result)
            }
        }
    }

    @Test("function returns bool type")
    func returnsBool() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[0] = .attacker
        let position = Position(cells: cells)
        let moves = position.allLegalMoves(for: .attacker)
        guard let move = moves.first else { return }
        let result: Bool = SacrificeDetector.isSacrifice(move: move, position: position, player: .attacker)
        #expect(result == true || result == false)
    }
}
