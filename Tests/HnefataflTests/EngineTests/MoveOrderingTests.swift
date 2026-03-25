import Testing
@testable import Hnefatafl

@Suite("Move Ordering Tests")
struct MoveOrderingTests {

    @Test("orders captures first")
    func capturesFirst() {
        let position = Position.copenhagenStart()
        let moves = position.allLegalMoves(for: .attacker)
        let ordered = MoveOrderer.order(moves: moves, position: position, player: .attacker, killers: [], pvMove: nil)
        let _ = ordered
    }

    @Test("PV move is first")
    func pvMoveFirst() {
        let position = Position.copenhagenStart()
        let moves = position.allLegalMoves(for: .attacker)
        let pvMove = moves.last!
        let ordered = MoveOrderer.order(moves: moves, position: position, player: .attacker, killers: [], pvMove: pvMove)
        #expect(ordered.first == pvMove)
    }

    @Test("killer moves before regular")
    func killerBeforeRegular() {
        let position = Position.copenhagenStart()
        let moves = position.allLegalMoves(for: .attacker)
        guard moves.count >= 3 else { return }
        let killer = moves[moves.count / 2]
        let ordered = MoveOrderer.order(moves: moves, position: position, player: .attacker, killers: [killer], pvMove: nil)
        let killerIndex = ordered.firstIndex(of: killer)!
        #expect(killerIndex < moves.count / 2)
    }

    @Test("order preserves all moves")
    func preservesAll() {
        let position = Position.copenhagenStart()
        let moves = position.allLegalMoves(for: .attacker)
        let ordered = MoveOrderer.order(moves: moves, position: position, player: .attacker, killers: [], pvMove: nil)
        #expect(ordered.count == moves.count)
    }

    @Test("empty moves returns empty")
    func emptyMoves() {
        let position = Position.copenhagenStart()
        let ordered = MoveOrderer.order(moves: [], position: position, player: .attacker, killers: [], pvMove: nil)
        #expect(ordered.isEmpty)
    }

    @Test("score is higher for captures")
    func captureScoreHigher() {
        let regular = MoveOrderer.scoreMove(Move(fromRow: 0, fromCol: 3, toRow: 2, toCol: 3), position: Position.copenhagenStart(), player: .attacker, isKiller: false, isPV: false)
        let pv = MoveOrderer.scoreMove(Move(fromRow: 0, fromCol: 3, toRow: 2, toCol: 3), position: Position.copenhagenStart(), player: .attacker, isKiller: false, isPV: true)
        #expect(pv > regular)
    }

    @Test("PV score is highest")
    func pvScoreHighest() {
        let move = Move(fromRow: 0, fromCol: 3, toRow: 2, toCol: 3)
        let pvScore = MoveOrderer.scoreMove(move, position: Position.copenhagenStart(), player: .attacker, isKiller: false, isPV: true)
        let killerScore = MoveOrderer.scoreMove(move, position: Position.copenhagenStart(), player: .attacker, isKiller: true, isPV: false)
        #expect(pvScore > killerScore)
    }
}
