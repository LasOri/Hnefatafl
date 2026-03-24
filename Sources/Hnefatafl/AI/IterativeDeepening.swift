struct SearchResult: Equatable {
    let move: Move?
    let score: Int?
    let depthReached: Int
}

struct IterativeDeepening {
    static func search(game: Game, maxDepth: Int) -> SearchResult {
        guard game.status == .inProgress else {
            return SearchResult(move: nil, score: nil, depthReached: 0)
        }

        var bestMove: Move? = nil
        var bestScore: Int? = nil
        var depthReached = 0

        for depth in 1...maxDepth {
            let moves = game.position.allLegalMoves(for: game.currentPlayer)
            guard !moves.isEmpty else { break }

            var currentBest = moves[0]
            var currentBestScore = Int.min

            for move in moves {
                let newGame = game.makeMove(move)
                let score = EvaluationAI.minimax(
                    game: newGame,
                    depth: depth - 1,
                    alpha: Int.min + 1,
                    beta: Int.max,
                    maximizing: false,
                    forPlayer: game.currentPlayer
                )
                if score > currentBestScore {
                    currentBestScore = score
                    currentBest = move
                }
            }

            bestMove = currentBest
            bestScore = currentBestScore
            depthReached = depth
        }

        return SearchResult(move: bestMove, score: bestScore, depthReached: depthReached)
    }
}
