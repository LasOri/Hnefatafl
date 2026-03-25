struct IDSearchResult: Equatable {
    let bestMove: Move?
    let score: Int
    let depthReached: Int
}

enum IterativeDeepeningSearch {
    static func search(position: Position, player: Player, maxDepth: Int) -> IDSearchResult {
        var bestResult = IDSearchResult(bestMove: nil, score: 0, depthReached: 0)
        for depth in 1...maxDepth {
            let moves = position.allLegalMoves(for: player)
            guard !moves.isEmpty else { break }
            var bestScore = Int.min
            var bestMove: Move? = nil
            for move in moves {
                let newPos = position.applyMove(move)
                let score = -negamax(position: newPos, player: player == .attacker ? .defender : .attacker, depth: depth - 1)
                if score > bestScore {
                    bestScore = score
                    bestMove = move
                }
            }
            bestResult = IDSearchResult(bestMove: bestMove, score: bestScore, depthReached: depth)
        }
        return bestResult
    }

    private static func negamax(position: Position, player: Player, depth: Int) -> Int {
        if depth == 0 { return staticEval(position: position, player: player) }
        let moves = position.allLegalMoves(for: player)
        if moves.isEmpty { return -10000 }
        var best = Int.min
        for move in moves {
            let newPos = position.applyMove(move)
            let score = -negamax(position: newPos, player: player == .attacker ? .defender : .attacker, depth: depth - 1)
            best = max(best, score)
        }
        return best
    }

    private static func staticEval(position: Position, player: Player) -> Int {
        switch player {
        case .attacker: return position.attackerCount - position.defenderCount
        case .defender: return position.defenderCount - position.attackerCount
        }
    }
}
