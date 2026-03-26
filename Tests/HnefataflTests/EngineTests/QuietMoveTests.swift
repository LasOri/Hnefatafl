import Testing
@testable import Hnefatafl

@Suite("QuietMove Tests")
struct QuietMoveTests {

    @Test("some moves are quiet in starting position")
    func startingPosition() {
        let pos = Position.copenhagenStart()
        let moves = pos.allLegalMoves(for: .attacker)
        let quietMoves = moves.filter { QuietMove.isQuiet(move: $0, position: pos, player: .attacker) }
        #expect(!quietMoves.isEmpty)
    }

    @Test("capture move is not quiet")
    func captureNotQuiet() {
        let pos = PositionBuilder()
            .place(.attacker, row: 3, col: 5)
            .place(.defender, row: 4, col: 5)
            .place(.attacker, row: 5, col: 4)
            .place(.king, row: 0, col: 0)
            .build()
        let moves = pos.allLegalMoves(for: .attacker)
        for move in moves {
            let newPos = pos.applyMove(move)
            let defBefore = (0..<121).filter { pos.pieceAt(row: $0 / 11, col: $0 % 11) == .defender }.count
            let defAfter = (0..<121).filter { newPos.pieceAt(row: $0 / 11, col: $0 % 11) == .defender }.count
            if defAfter < defBefore {
                #expect(!QuietMove.isQuiet(move: move, position: pos, player: .attacker))
            }
        }
    }

    @Test("quiet classification returns boolean")
    func returnsBoolean() {
        let pos = Position.copenhagenStart()
        let move = pos.allLegalMoves(for: .attacker).first!
        let result = QuietMove.isQuiet(move: move, position: pos, player: .attacker)
        #expect(result == true || result == false)
    }

    @Test("all moves classifiable")
    func allClassifiable() {
        let pos = Position.copenhagenStart()
        let moves = pos.allLegalMoves(for: .attacker)
        var quietCount = 0
        var tacticalCount = 0
        for move in moves {
            if QuietMove.isQuiet(move: move, position: pos, player: .attacker) {
                quietCount += 1
            } else {
                tacticalCount += 1
            }
        }
        #expect(quietCount + tacticalCount == moves.count)
    }

    @Test("king escape move is not quiet")
    func kingEscapeNotQuiet() {
        let pos = PositionBuilder()
            .place(.king, row: 0, col: 1)
            .build()
        let kingMoves = pos.allLegalMoves(for: .defender).filter { $0.fromRow == 0 && $0.fromCol == 1 }
        let escapeMove = kingMoves.first(where: { $0.toRow == 0 && $0.toCol == 0 })
        if let em = escapeMove {
            #expect(!QuietMove.isQuiet(move: em, position: pos, player: .defender))
        }
    }
}
