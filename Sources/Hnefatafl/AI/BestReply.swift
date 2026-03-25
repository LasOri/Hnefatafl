struct BestReplyResult: Equatable {
    let move: Move?
    let score: Int
}

enum BestReply {
    static func find(position: Position, player: Player) -> BestReplyResult {
        let moves = position.allLegalMoves(for: player)
        guard !moves.isEmpty else { return BestReplyResult(move: nil, score: 0) }
        var best: Move? = nil
        var bestScore = Int.min
        for move in moves {
            let newPos = position.applyMove(move)
            let score = staticEval(position: newPos, player: player)
            if score > bestScore {
                bestScore = score
                best = move
            }
        }
        return BestReplyResult(move: best, score: bestScore)
    }

    private static func staticEval(position: Position, player: Player) -> Int {
        switch player {
        case .attacker:
            return position.attackerCount * 100 - position.defenderCount * 150
        case .defender:
            return position.defenderCount * 150 - position.attackerCount * 100
        }
    }
}
