import LINKER

struct GameExporter {
    static func export(game: Game) -> String {
        var lines: [String] = []
        lines.append("[Game \"Hnefatafl\"]")
        lines.append("[Variant \"Copenhagen\"]")

        let dateStr = formatPGNDate(from: currentTimestamp())
        lines.append("[Date \"\(dateStr)\"]")

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

    static func formatPGNDate(from timestamp: Double) -> String {
        let totalSeconds = Int(timestamp)
        let z = totalSeconds / 86400 + 719468
        let era = (z >= 0 ? z : z - 146096) / 146097
        let doe = z - era * 146097
        let yoe = (doe - doe / 1460 + doe / 36524 - doe / 146096) / 365
        let y = yoe + era * 400
        let doy = doe - (365 * yoe + yoe / 4 - yoe / 100)
        let mp = (5 * doy + 2) / 153
        let d = doy - (153 * mp + 2) / 5 + 1
        let m = mp + (mp < 10 ? 3 : -9)
        let year = y + (m <= 2 ? 1 : 0)
        return "\(year).\(zeroPad(m, width: 2)).\(zeroPad(d, width: 2))"
    }
}

struct GameImporter {
    static func parseHeaders(_ pgn: String) -> [String: String] {
        var headers: [String: String] = [:]
        for line in pgn.split(separator: "\n") {
            let trimmed = line.trimmingWhitespace()
            if trimmed.hasPrefix("[") && trimmed.hasSuffix("]") {
                let inner = String(trimmed.dropFirst().dropLast())
                if let spaceIdx = inner.firstIndex(of: " ") {
                    let key = String(inner[inner.startIndex..<spaceIdx])
                    let value = String(inner[inner.index(after: spaceIdx)...])
                        .filter { $0 != "\"" }
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
            let trimmed = line.trimmingWhitespace()
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
