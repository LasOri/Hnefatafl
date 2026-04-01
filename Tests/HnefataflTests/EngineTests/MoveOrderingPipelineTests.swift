import Testing
@testable import Hnefatafl

@Suite("MoveOrderingPipeline Tests")
struct MoveOrderingPipelineTests {

    @Test("pipeline preserves all moves")
    func preservesAllMoves() {
        let position = Position.copenhagenStart()
        let moves = position.allLegalMoves(for: .attacker)
        let killers = KillerMoveTable()
        let history = HistoryTable()
        let ordered = MoveOrderingPipeline.order(
            moves: moves,
            position: position,
            player: .attacker,
            killers: killers,
            history: history,
            depth: 0,
            pvMove: nil
        )
        #expect(ordered.count == moves.count)
        for move in moves {
            #expect(ordered.contains(move))
        }
    }

    @Test("captures are ordered before non-captures")
    func capturesBeforeNonCaptures() {
        // Set up a position where an attacker move to col 4 captures the defender
        // Attacker at (3,3), defender at (3,4), attacker at (3,5)
        // Moving attacker from (3,3) to (3,3) won't capture, but moving attacker from row 1 col 4 to row 3 col 4... no.
        // Instead: attacker at (2,4), defender at (3,4), attacker already at (4,4)
        // Moving (2,4) -> (2,4) is not useful. We need to create a capture scenario.
        // Attacker at (2,4) moves to (2,4) is identity.
        // Let's place: attacker at (1,4), attacker at (3,4), defender at (2,4).
        // Attacker move (1,4) -> (1, something) is non-capture.
        // For a capture: place attacker at (2,3), defender at (2,4), attacker at (2,5).
        // Then a different attacker at (0,4) can move to (2,4)... no, (2,4) is occupied by defender.
        // Custodial capture: attacker at (1,4) and attacker at (3,4) with defender at (2,4).
        // We need an attacker that moves next to the defender to create the sandwich.
        // Place: defender at (2,4), attacker at (3,4), attacker at (1,0).
        // Move attacker (1,0) -> (1,4): now attacker at (1,4) and (3,4) sandwich defender at (2,4). Capture!
        let position = emptyBoard()
            .placing(.defender, row: 2, col: 4)
            .placing(.attacker, row: 3, col: 4)
            .placing(.attacker, row: 1, col: 0)
            .placing(.king, row: 9, col: 9)
            .build()

        let captureMove = Move(fromRow: 1, fromCol: 0, toRow: 1, toCol: 4)
        let quietMove = Move(fromRow: 1, fromCol: 0, toRow: 1, toCol: 2)

        let killers = KillerMoveTable()
        let history = HistoryTable()
        let ordered = MoveOrderingPipeline.order(
            moves: [quietMove, captureMove],
            position: position,
            player: .attacker,
            killers: killers,
            history: history,
            depth: 0,
            pvMove: nil
        )
        let captureIndex = ordered.firstIndex(of: captureMove)!
        let quietIndex = ordered.firstIndex(of: quietMove)!
        #expect(captureIndex < quietIndex)
    }

    @Test("PV move is placed first")
    func pvMoveFirst() {
        let position = Position.copenhagenStart()
        let moves = position.allLegalMoves(for: .attacker)
        let pvMove = moves.last!
        let killers = KillerMoveTable()
        let history = HistoryTable()
        let ordered = MoveOrderingPipeline.order(
            moves: moves,
            position: position,
            player: .attacker,
            killers: killers,
            history: history,
            depth: 0,
            pvMove: pvMove
        )
        #expect(ordered.first == pvMove)
    }

    @Test("killer moves before non-killer non-capture moves")
    func killerMovesBeforeQuiet() {
        let position = Position.copenhagenStart()
        let moves = position.allLegalMoves(for: .attacker)
        guard moves.count >= 4 else { return }

        let killerMove = moves[moves.count / 2]
        var killers = KillerMoveTable()
        killers.store(move: killerMove, at: 3)

        let history = HistoryTable()
        let ordered = MoveOrderingPipeline.order(
            moves: moves,
            position: position,
            player: .attacker,
            killers: killers,
            history: history,
            depth: 3,
            pvMove: nil
        )

        let killerIndex = ordered.firstIndex(of: killerMove)!
        // Killer should be near the front (within the top portion)
        #expect(killerIndex < moves.count / 2)
    }

    @Test("history table scores influence ordering")
    func historyInfluencesOrdering() {
        let position = Position.copenhagenStart()
        let moves = position.allLegalMoves(for: .attacker)
        guard moves.count >= 2 else { return }

        let boostedMove = moves.last!
        var history = HistoryTable()
        // Record at high depth many times to give a strong history score
        history.record(move: boostedMove, depth: 10)
        history.record(move: boostedMove, depth: 10)
        history.record(move: boostedMove, depth: 10)

        let killers = KillerMoveTable()
        let ordered = MoveOrderingPipeline.order(
            moves: moves,
            position: position,
            player: .attacker,
            killers: killers,
            history: history,
            depth: 0,
            pvMove: nil
        )

        let boostedIndex = ordered.firstIndex(of: boostedMove)!
        let originalIndex = moves.firstIndex(of: boostedMove)!
        // The boosted move should be ordered earlier than its original position
        #expect(boostedIndex < originalIndex)
    }

    @Test("empty move list returns empty list")
    func emptyMovesReturnsEmpty() {
        let position = Position.copenhagenStart()
        let killers = KillerMoveTable()
        let history = HistoryTable()
        let ordered = MoveOrderingPipeline.order(
            moves: [],
            position: position,
            player: .attacker,
            killers: killers,
            history: history,
            depth: 0,
            pvMove: nil
        )
        #expect(ordered.isEmpty)
    }
}
