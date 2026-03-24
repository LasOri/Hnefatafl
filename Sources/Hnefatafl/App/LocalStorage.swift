struct SaveData: Equatable {
    let positionString: String
    let moveCount: Int
    let currentPlayer: Player
    let muted: Bool
    let aiDifficulty: AIDifficulty

    static func from(state: GameState) -> SaveData {
        SaveData(
            positionString: PositionSerializer.serialize(position: state.game.position),
            moveCount: state.game.moveHistory.count,
            currentPlayer: state.game.currentPlayer,
            muted: state.muted,
            aiDifficulty: state.aiDifficulty
        )
    }
}

struct SaveEncoder {
    static let storageKey = "hnefatafl-save"

    static func encode(_ data: SaveData) -> String {
        let playerStr = data.currentPlayer == .attacker ? "attacker" : "defender"
        let diffStr: String
        switch data.aiDifficulty {
        case .easy: diffStr = "easy"
        case .medium: diffStr = "medium"
        case .hard: diffStr = "hard"
        }
        return """
        {"positionString":"\(data.positionString)","moveCount":\(data.moveCount),"currentPlayer":"\(playerStr)","muted":\(data.muted),"aiDifficulty":"\(diffStr)"}
        """
    }

    static func decode(_ json: String) -> SaveData? {
        let trimmed = json.trimmingCharacters(in: .whitespacesAndNewlines)
        guard trimmed.hasPrefix("{") && trimmed.hasSuffix("}") else { return nil }

        func extractString(_ key: String) -> String? {
            guard let range = trimmed.range(of: "\"\(key)\":\"") else { return nil }
            let start = range.upperBound
            guard let end = trimmed[start...].firstIndex(of: "\"") else { return nil }
            return String(trimmed[start..<end])
        }

        func extractInt(_ key: String) -> Int? {
            guard let range = trimmed.range(of: "\"\(key)\":") else { return nil }
            let start = range.upperBound
            var numStr = ""
            for char in trimmed[start...] {
                if char.isNumber || char == "-" { numStr.append(char) }
                else { break }
            }
            return Int(numStr)
        }

        func extractBool(_ key: String) -> Bool? {
            guard let range = trimmed.range(of: "\"\(key)\":") else { return nil }
            let start = range.upperBound
            let rest = String(trimmed[start...])
            if rest.hasPrefix("true") { return true }
            if rest.hasPrefix("false") { return false }
            return nil
        }

        guard let posStr = extractString("positionString"),
              let moveCount = extractInt("moveCount"),
              let playerStr = extractString("currentPlayer"),
              let muted = extractBool("muted"),
              let diffStr = extractString("aiDifficulty") else { return nil }

        let player: Player = playerStr == "attacker" ? .attacker : .defender
        let difficulty: AIDifficulty
        switch diffStr {
        case "easy": difficulty = .easy
        case "hard": difficulty = .hard
        default: difficulty = .medium
        }

        return SaveData(positionString: posStr, moveCount: moveCount, currentPlayer: player, muted: muted, aiDifficulty: difficulty)
    }
}
