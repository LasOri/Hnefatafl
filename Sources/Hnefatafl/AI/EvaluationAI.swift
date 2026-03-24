struct EvaluationAI {
    static func pickMove(game: Game) -> Move? {
        pickMove(game: game, depth: 3)
    }

    static func pickMove(game: Game, depth: Int) -> Move? {
        let moves = game.position.allLegalMoves(for: game.currentPlayer)
        guard !moves.isEmpty else { return nil }

        var bestMove = moves[0]
        var bestScore = Int.min

        for move in moves {
            let newGame = game.makeMove(move)
            let score: Int
            if depth <= 0 {
                score = evaluate(position: newGame.position, for: game.currentPlayer)
            } else {
                score = minimax(
                    game: newGame,
                    depth: depth - 1,
                    alpha: Int.min + 1,
                    beta: Int.max,
                    maximizing: false,
                    forPlayer: game.currentPlayer
                )
            }
            if score > bestScore {
                bestScore = score
                bestMove = move
            }
        }

        return bestMove
    }

    static func minimax(
        game: Game,
        depth: Int,
        alpha: Int,
        beta: Int,
        maximizing: Bool,
        forPlayer: Player
    ) -> Int {
        if depth <= 0 || game.status != .inProgress {
            return evaluate(position: game.position, for: forPlayer)
        }

        let moves = game.position.allLegalMoves(for: game.currentPlayer)
        if moves.isEmpty {
            return evaluate(position: game.position, for: forPlayer)
        }

        var alpha = alpha
        var beta = beta

        if maximizing {
            var maxScore = Int.min
            for move in moves {
                let newGame = game.makeMove(move)
                let score = minimax(
                    game: newGame,
                    depth: depth - 1,
                    alpha: alpha,
                    beta: beta,
                    maximizing: false,
                    forPlayer: forPlayer
                )
                maxScore = max(maxScore, score)
                alpha = max(alpha, score)
                if alpha >= beta { break }
            }
            return maxScore
        } else {
            var minScore = Int.max
            for move in moves {
                let newGame = game.makeMove(move)
                let score = minimax(
                    game: newGame,
                    depth: depth - 1,
                    alpha: alpha,
                    beta: beta,
                    maximizing: true,
                    forPlayer: forPlayer
                )
                minScore = min(minScore, score)
                beta = min(beta, score)
                if alpha >= beta { break }
            }
            return minScore
        }
    }

    static func evaluate(position: Position, for player: Player) -> Int {
        let defenderScore = evaluateForDefender(position: position)
        return player == .defender ? defenderScore : -defenderScore
    }

    private static func evaluateForDefender(position: Position) -> Int {
        let status = Position.gameStatus(position)
        if status == .defenderWins { return 10000 }
        if status == .attackerWins { return -10000 }
        if status == .draw { return 0 }

        var score = 0

        let defenderCount = position.defenderCount
        let attackerCount = position.attackerCount

        score += defenderCount * 10
        score -= attackerCount * 10

        guard let king = findKing(position) else {
            return score - 1000
        }

        score += 100

        let cornerDistance = minCornerDistance(row: king.row, col: king.col)
        score -= cornerDistance * 5

        let kingMoves = position.legalMoves(forPieceAtRow: king.row, col: king.col)
        score += kingMoves.count * 2

        let corners = [(0, 0), (0, 10), (10, 0), (10, 10)]
        for (cr, cc) in corners {
            if isCornerBlocked(position: position, cornerRow: cr, cornerCol: cc) {
                score -= 15
            }
        }

        return score
    }

    private static func findKing(_ position: Position) -> (row: Int, col: Int)? {
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .king {
                    return (row, col)
                }
            }
        }
        return nil
    }

    private static func minCornerDistance(row: Int, col: Int) -> Int {
        let corners = [(0, 0), (0, 10), (10, 0), (10, 10)]
        return corners.map { abs(row - $0.0) + abs(col - $0.1) }.min() ?? 20
    }

    private static func isCornerBlocked(position: Position, cornerRow: Int, cornerCol: Int) -> Bool {
        let adjacents: [(Int, Int)]
        if cornerRow == 0 && cornerCol == 0 {
            adjacents = [(0, 1), (1, 0)]
        } else if cornerRow == 0 && cornerCol == 10 {
            adjacents = [(0, 9), (1, 10)]
        } else if cornerRow == 10 && cornerCol == 0 {
            adjacents = [(10, 1), (9, 0)]
        } else {
            adjacents = [(10, 9), (9, 10)]
        }

        return adjacents.allSatisfy { position.pieceAt(row: $0.0, col: $0.1) == .attacker }
    }
}
