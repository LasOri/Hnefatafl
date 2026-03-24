import Foundation

struct SaveState: Codable, Equatable {
    let cells: [String?]
    let currentPlayer: String
    let moveHistory: [[Int]]
    let muted: Bool
    let difficulty: String
}

struct GameSerializer {
    static func serialize(_ state: GameState) -> SaveState {
        let cells: [String?] = state.game.position.cells.map { piece in
            switch piece {
            case .attacker: return "attacker"
            case .defender: return "defender"
            case .king: return "king"
            case nil: return nil
            }
        }

        let moveHistory: [[Int]] = state.game.moveHistory.map { move in
            [move.fromRow, move.fromCol, move.toRow, move.toCol]
        }

        let difficulty: String
        switch state.aiDifficulty {
        case .easy: difficulty = "easy"
        case .medium: difficulty = "medium"
        case .hard: difficulty = "hard"
        }

        return SaveState(
            cells: cells,
            currentPlayer: state.game.currentPlayer == .attacker ? "attacker" : "defender",
            moveHistory: moveHistory,
            muted: state.muted,
            difficulty: difficulty
        )
    }

    static func deserialize(_ save: SaveState) -> GameState? {
        guard save.cells.count == Position.cellCount else { return nil }

        let player: Player
        switch save.currentPlayer {
        case "attacker": player = .attacker
        case "defender": player = .defender
        default: return nil
        }

        let cells: [Piece?] = save.cells.map { name in
            switch name {
            case "attacker": return .attacker
            case "defender": return .defender
            case "king": return .king
            default: return nil
            }
        }

        let moves: [Move] = save.moveHistory.compactMap { coords in
            guard coords.count == 4 else { return nil }
            return Move(fromRow: coords[0], fromCol: coords[1], toRow: coords[2], toCol: coords[3])
        }

        let difficulty: AIDifficulty
        switch save.difficulty {
        case "easy": difficulty = .easy
        case "hard": difficulty = .hard
        default: difficulty = .medium
        }

        let position = Position(cells: cells)
        let game = Game(position: position, currentPlayer: player, moveHistory: moves)
        return GameState(
            game: game,
            selectedSquare: nil,
            legalMovesForSelected: [],
            muted: save.muted,
            aiDifficulty: difficulty
        )
    }
}
