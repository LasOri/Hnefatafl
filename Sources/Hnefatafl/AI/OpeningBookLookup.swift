enum OpeningBookLookup {
    /// Returns a known opening book move for the current game state, or nil if none found.
    /// Verifies the move is legal in the current position before returning it.
    static func lookup(game: Game) -> Move? {
        let history = game.moveHistory

        for opening in OpeningBook.allOpenings {
            guard history.count < opening.moves.count else { continue }

            let prefix = Array(opening.moves.prefix(history.count))
            guard prefix == history else { continue }

            let nextMove = opening.moves[history.count]

            let legalMoves = game.position.allLegalMoves(for: game.currentPlayer)
            guard legalMoves.contains(nextMove) else { continue }

            return nextMove
        }

        return nil
    }
}
