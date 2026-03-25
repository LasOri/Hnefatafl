enum GameNotation {
    static func exportMoves(_ game: Game) -> [String] {
        game.moveHistory.map { AlgebraicNotation.formatMove($0) }
    }

    static func importMoves(_ notations: [String], startingPosition: Position) -> Game? {
        var game = Game(position: startingPosition, currentPlayer: .attacker, moveHistory: [])

        for notation in notations {
            guard let move = AlgebraicNotation.parseMove(notation) else { return nil }
            let legalMoves = game.position.allLegalMoves(for: game.currentPlayer)
            guard legalMoves.contains(move) else { return nil }
            game = game.makeMove(move)
        }

        return game
    }

    static func exportToString(_ game: Game) -> String {
        exportMoves(game).joined(separator: "\n")
    }

    static func importFromString(_ text: String, startingPosition: Position) -> Game? {
        let lines = text.split(separator: "\n").map(String.init).filter { !$0.isEmpty }
        return importMoves(lines, startingPosition: startingPosition)
    }
}
