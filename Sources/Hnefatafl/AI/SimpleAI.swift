struct SimpleAI {
    static func pickMove(game: Game) -> Move? {
        let moves = game.position.allLegalMoves(for: game.currentPlayer)
        guard !moves.isEmpty else { return nil }
        return moves.randomElement()
    }
}
