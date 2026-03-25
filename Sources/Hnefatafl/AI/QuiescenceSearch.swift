struct QuiescenceSearch {
    static let maxDepth = 4

    static func search(game: Game, alpha: Int, beta: Int, player: Player, depth: Int) -> Int {
        let standPat = EvaluationAI.evaluate(position: game.position, for: player)

        if depth <= 0 || game.status != .inProgress {
            return standPat
        }

        var alpha = alpha
        if standPat >= beta { return beta }
        if standPat > alpha { alpha = standPat }

        let captures = captureMoves(game: game)
        if captures.isEmpty { return standPat }

        for move in captures {
            let newGame = game.makeMove(move)
            let score = -search(game: newGame, alpha: -beta, beta: -alpha, player: player, depth: depth - 1)
            if score >= beta { return beta }
            if score > alpha { alpha = score }
        }

        return alpha
    }

    static func captureMoves(game: Game) -> [Move] {
        let moves = game.position.allLegalMoves(for: game.currentPlayer)
        return moves.filter { move in
            let newGame = game.makeMove(move)
            let beforeCount = game.position.cells.compactMap { $0 }.count
            let afterCount = newGame.position.cells.compactMap { $0 }.count
            return afterCount < beforeCount
        }
    }
}
