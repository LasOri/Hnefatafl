import Testing
@testable import Hnefatafl

@Suite("Evaluation AI Tests")
struct EvaluationAITests {

    @Test("pickMove returns a legal move")
    func returnsLegalMove() {
        let game = Game()
        let move = EvaluationAI.pickMove(game: game)
        #expect(move != nil)
        let legal = game.position.allLegalMoves(for: game.currentPlayer)
        #expect(legal.contains(where: { $0 == move }))
    }

    @Test("pickMove returns nil when no moves available")
    func returnsNilWhenNoMoves() {
        let position = emptyBoard()
            .placing(.king, row: 0, col: 0)
            .build()
        let game = Game(position: position, currentPlayer: .attacker, moveHistory: [])
        let move = EvaluationAI.pickMove(game: game)
        #expect(move == nil)
    }

    @Test("evaluate scores king near corner higher for defender")
    func kingNearCornerHigherScore() {
        let nearCorner = emptyBoard()
            .placing(.king, row: 0, col: 1)
            .placing(.attacker, row: 5, col: 5)
            .build()
        let farFromCorner = emptyBoard()
            .placing(.king, row: 5, col: 4)
            .placing(.attacker, row: 9, col: 9)
            .build()
        let nearScore = EvaluationAI.evaluate(position: nearCorner, for: .defender)
        let farScore = EvaluationAI.evaluate(position: farFromCorner, for: .defender)
        #expect(nearScore > farScore)
    }

    @Test("evaluate scores more defenders higher")
    func moreDefendersHigherScore() {
        let moreDefenders = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.defender, row: 4, col: 4)
            .placing(.defender, row: 6, col: 6)
            .placing(.attacker, row: 0, col: 0)
            .placing(.attacker, row: 10, col: 10)
            .build()
        let fewerDefenders = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 0, col: 0)
            .placing(.attacker, row: 10, col: 10)
            .build()
        let more = EvaluationAI.evaluate(position: moreDefenders, for: .defender)
        let fewer = EvaluationAI.evaluate(position: fewerDefenders, for: .defender)
        #expect(more > fewer)
    }

    @Test("evaluate scores fewer attackers higher for defender")
    func fewerAttackersHigherForDefender() {
        let manyAttackers = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 0, col: 0)
            .placing(.attacker, row: 0, col: 1)
            .placing(.attacker, row: 0, col: 2)
            .build()
        let fewAttackers = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 0, col: 0)
            .build()
        let many = EvaluationAI.evaluate(position: manyAttackers, for: .defender)
        let few = EvaluationAI.evaluate(position: fewAttackers, for: .defender)
        #expect(few > many)
    }

    @Test("AI prefers capture move over non-capture")
    func prefersCaptureMove() {
        let position = emptyBoard()
            .placing(.attacker, row: 3, col: 0)
            .placing(.defender, row: 3, col: 1)
            .placing(.attacker, row: 3, col: 3)
            .placing(.king, row: 8, col: 8)
            .build()
        let game = Game(position: position, currentPlayer: .attacker, moveHistory: [])
        let move = EvaluationAI.pickMove(game: game)
        #expect(move != nil)
        #expect(move?.toRow == 3)
        #expect(move?.toCol == 2)
    }

    @Test("AI deterministic for same position")
    func deterministic() {
        let game = Game()
        let move1 = EvaluationAI.pickMove(game: game)
        let move2 = EvaluationAI.pickMove(game: game)
        #expect(move1 == move2)
    }

    @Test("evaluate returns higher score for attacker with more attackers")
    func moreAttackersHigherForAttacker() {
        let manyAttackers = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 0, col: 0)
            .placing(.attacker, row: 0, col: 1)
            .placing(.attacker, row: 0, col: 2)
            .build()
        let fewAttackers = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 0, col: 0)
            .build()
        let many = EvaluationAI.evaluate(position: manyAttackers, for: .attacker)
        let few = EvaluationAI.evaluate(position: fewAttackers, for: .attacker)
        #expect(many > few)
    }

    @Test("AI handles position with only king")
    func onlyKingPosition() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 0, col: 0)
            .build()
        let game = Game(position: position, currentPlayer: .attacker, moveHistory: [])
        let move = EvaluationAI.pickMove(game: game)
        #expect(move != nil)
    }

    @Test("AI as defender moves king toward corner")
    func defenderMovesKingTowardCorner() {
        let position = emptyBoard()
            .placing(.king, row: 1, col: 1)
            .placing(.attacker, row: 5, col: 5)
            .build()
        let game = Game(position: position, currentPlayer: .defender, moveHistory: [])
        let move = EvaluationAI.pickMove(game: game)
        #expect(move != nil)
        if let move {
            let afterPosition = position.applyMove(move)
            let kingAfter = findKingPosition(afterPosition)
            let distBefore = minCornerDist(row: 1, col: 1)
            let distAfter = minCornerDist(row: kingAfter?.row ?? 1, col: kingAfter?.col ?? 1)
            #expect(distAfter <= distBefore)
        }
    }

    @Test("evaluate penalizes blocked corners for defender")
    func blockedCornersPenalizeDefender() {
        let blocked = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 0, col: 1)
            .placing(.attacker, row: 1, col: 0)
            .placing(.attacker, row: 0, col: 9)
            .placing(.attacker, row: 1, col: 10)
            .build()
        let unblocked = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 5, col: 0)
            .placing(.attacker, row: 5, col: 10)
            .placing(.attacker, row: 0, col: 5)
            .placing(.attacker, row: 10, col: 5)
            .build()
        let blockedScore = EvaluationAI.evaluate(position: blocked, for: .defender)
        let unblockedScore = EvaluationAI.evaluate(position: unblocked, for: .defender)
        #expect(unblockedScore > blockedScore)
    }
}

private func findKingPosition(_ position: Position) -> (row: Int, col: Int)? {
    for row in 0..<Position.boardSize {
        for col in 0..<Position.boardSize {
            if position.pieceAt(row: row, col: col) == .king {
                return (row, col)
            }
        }
    }
    return nil
}

private func minCornerDist(row: Int, col: Int) -> Int {
    [(0, 0), (0, 10), (10, 0), (10, 10)].map { abs(row - $0.0) + abs(col - $0.1) }.min() ?? 20
}
