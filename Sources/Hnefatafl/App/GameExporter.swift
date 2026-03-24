import Foundation

struct GameExporter {
    static func export(game: Game) -> String {
        var lines: [String] = []
        lines.append("[Game \"Hnefatafl\"]")
        lines.append("[Variant \"Copenhagen\"]")

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        lines.append("[Date \"\(formatter.string(from: Date()))\"]")

        let result = resultString(for: game.status)
        lines.append("[Result \"\(result)\"]")
        lines.append("")

        let moves = game.moveHistory
        if !moves.isEmpty {
            var moveLines: [String] = []
            var pair = ""
            for (i, move) in moves.enumerated() {
                let notation = NotationExporter.algebraic(move)
                if i % 2 == 0 {
                    pair = "\(i / 2 + 1). \(notation)"
                } else {
                    pair += " \(notation)"
                    moveLines.append(pair)
                    pair = ""
                }
            }
            if !pair.isEmpty { moveLines.append(pair) }
            lines.append(moveLines.joined(separator: "\n"))
        }

        return lines.joined(separator: "\n")
    }

    static func resultString(for status: GameStatus) -> String {
        switch status {
        case .attackerWins: return "1-0"
        case .defenderWins: return "0-1"
        case .draw: return "1/2-1/2"
        case .inProgress: return "*"
        }
    }
}

struct GameImporter {
    static func parseHeaders(_ pgn: String) -> [String: String] {
        var headers: [String: String] = [:]
        for line in pgn.split(separator: "\n") {
            let trimmed = line.trimmingCharacters(in: .whitespaces)
            if trimmed.hasPrefix("[") && trimmed.hasSuffix("]") {
                let inner = String(trimmed.dropFirst().dropLast())
                if let spaceIdx = inner.firstIndex(of: " ") {
                    let key = String(inner[inner.startIndex..<spaceIdx])
                    var value = String(inner[inner.index(after: spaceIdx)...])
                    value = value.trimmingCharacters(in: CharacterSet(charactersIn: "\""))
                    headers[key] = value
                }
            }
        }
        return headers
    }

    static func parseMoveText(_ pgn: String) -> String {
        let lines = pgn.split(separator: "\n", omittingEmptySubsequences: false)
        var pastHeaders = false
        var moveLines: [String] = []
        for line in lines {
            let trimmed = line.trimmingCharacters(in: .whitespaces)
            if trimmed.isEmpty && !pastHeaders {
                pastHeaders = true
                continue
            }
            if pastHeaders && !trimmed.isEmpty {
                moveLines.append(trimmed)
            }
        }
        return moveLines.joined(separator: " ")
    }
}
