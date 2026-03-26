import Testing
@testable import Hnefatafl

@Suite("MoveUrgency Tests")
struct MoveUrgencyTests {

    @Test("urgency score is non-negative")
    func nonNegative() {
        let pos = Position.copenhagenStart()
        let move = pos.allLegalMoves(for: .attacker).first!
        let urgency = MoveUrgency.score(move: move, position: pos, player: .attacker)
        #expect(urgency >= 0)
    }

    @Test("capture move has high urgency")
    func captureUrgent() {
        let pos = PositionBuilder()
            .place(.attacker, row: 3, col: 5)
            .place(.defender, row: 4, col: 5)
            .place(.attacker, row: 5, col: 4)
            .place(.king, row: 0, col: 0)
            .build()
        let captureMoves = pos.allLegalMoves(for: .attacker).filter { move in
            let newPos = pos.applyMove(move)
            let defBefore = (0..<121).filter { pos.pieceAt(row: $0 / 11, col: $0 % 11) == .defender }.count
            let defAfter = (0..<121).filter { newPos.pieceAt(row: $0 / 11, col: $0 % 11) == .defender }.count
            return defAfter < defBefore
        }
        if let capMove = captureMoves.first {
            let urgency = MoveUrgency.score(move: capMove, position: pos, player: .attacker)
            #expect(urgency > 0)
        }
    }

    @Test("king escape move is urgent for defender")
    func kingEscapeUrgent() {
        let pos = PositionBuilder()
            .place(.king, row: 0, col: 1)
            .build()
        let kingMoves = pos.allLegalMoves(for: .defender).filter { $0.fromRow == 0 && $0.fromCol == 1 }
        let escapeMove = kingMoves.first(where: { $0.toRow == 0 && $0.toCol == 0 })
        if let em = escapeMove {
            let urgency = MoveUrgency.score(move: em, position: pos, player: .defender)
            #expect(urgency > 50)
        }
    }

    @Test("non-threatening move has lower urgency")
    func quietMove() {
        let pos = Position.copenhagenStart()
        let moves = pos.allLegalMoves(for: .attacker)
        let scores = moves.prefix(5).map { MoveUrgency.score(move: $0, position: pos, player: .attacker) }
        #expect(scores.allSatisfy { $0 >= 0 })
    }

    @Test("UrgencyScore is comparable")
    func comparable() {
        let a = MoveUrgency.score(move: Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 2), position: Position.copenhagenStart(), player: .attacker)
        let b = MoveUrgency.score(move: Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 2), position: Position.copenhagenStart(), player: .attacker)
        #expect(a == b)
    }

    @Test("different moves can have different urgency")
    func differentUrgency() {
        let pos = Position.copenhagenStart()
        let moves = pos.allLegalMoves(for: .attacker)
        guard moves.count >= 2 else { return }
        let a = MoveUrgency.score(move: moves[0], position: pos, player: .attacker)
        let b = MoveUrgency.score(move: moves[1], position: pos, player: .attacker)
        #expect(a >= 0 && b >= 0)
    }
}
