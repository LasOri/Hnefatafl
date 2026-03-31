import LINKER

struct SaveState: Equatable {
    let cells: [String?]
    let currentPlayer: String
    let moveHistory: [[Int]]
    let muted: Bool
    let difficulty: String

    func toJson() -> Json {
        let cellsJson = Json.array(cells.map { cell in
            cell.map { Json.string($0) } ?? Json.null
        })
        let movesJson = Json.array(moveHistory.map { coords in
            Json.array(coords.map { Json.int($0) })
        })
        return .object([
            "cells": cellsJson,
            "currentPlayer": .string(currentPlayer),
            "moveHistory": movesJson,
            "muted": .bool(muted),
            "difficulty": .string(difficulty)
        ])
    }

    static func fromJson(_ json: Json) -> SaveState? {
        guard let cellsArr = json["cells"]?.arrayValue,
              let currentPlayer = json["currentPlayer"]?.stringValue,
              let movesArr = json["moveHistory"]?.arrayValue,
              let muted = json["muted"]?.boolValue,
              let difficulty = json["difficulty"]?.stringValue else {
            return nil
        }
        let cells: [String?] = cellsArr.map { $0.stringValue }
        let moveHistory: [[Int]] = movesArr.compactMap { move in
            move.arrayValue?.compactMap { $0.intValue }
        }
        return SaveState(cells: cells, currentPlayer: currentPlayer, moveHistory: moveHistory, muted: muted, difficulty: difficulty)
    }

    func toJsonString() -> String {
        toJson().toJsonString()
    }

    static func fromJsonString(_ jsonString: String) -> SaveState? {
        fromJson(Json.parse(jsonString))
    }
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
