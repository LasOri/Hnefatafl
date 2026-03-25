struct HnefataflPGN: Equatable {
    let headers: [String: String]
    let moves: [String]

    static func export(game: Game, headers: [String: String] = [:]) -> String {
        var allHeaders = headers
        if allHeaders["Variant"] == nil {
            allHeaders["Variant"] = "Copenhagen"
        }
        if allHeaders["Result"] == nil {
            allHeaders["Result"] = resultString(game.status)
        }

        var lines: [String] = []
        for (key, value) in allHeaders.sorted(by: { $0.key < $1.key }) {
            lines.append("[\(key) \"\(value)\"]")
        }
        lines.append("")

        if !game.moveHistory.isEmpty {
            let moveNotations = game.moveHistory.map { AlgebraicNotation.formatMove($0) }
            var moveText = ""
            var moveNumber = 1
            for i in stride(from: 0, to: moveNotations.count, by: 2) {
                if i > 0 { moveText += " " }
                moveText += "\(moveNumber)."
                moveText += " \(moveNotations[i])"
                if i + 1 < moveNotations.count {
                    moveText += " \(moveNotations[i + 1])"
                }
                moveNumber += 1
            }
            lines.append(moveText)
        }

        return lines.joined(separator: "\n")
    }

    static func parse(_ text: String) -> HnefataflPGN? {
        guard !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return nil }

        var headers: [String: String] = [:]
        var moveText = ""
        var inMoves = false

        for line in text.split(separator: "\n", omittingEmptySubsequences: false).map(String.init) {
            let trimmed = line.trimmingCharacters(in: .whitespaces)
            if trimmed.hasPrefix("[") && trimmed.hasSuffix("]") {
                let inner = String(trimmed.dropFirst().dropLast())
                if let spaceIndex = inner.firstIndex(of: " ") {
                    let key = String(inner[inner.startIndex..<spaceIndex])
                    var value = String(inner[inner.index(after: spaceIndex)...])
                    value = value.trimmingCharacters(in: .whitespaces)
                    if value.hasPrefix("\"") && value.hasSuffix("\"") {
                        value = String(value.dropFirst().dropLast())
                    }
                    headers[key] = value
                }
            } else if trimmed.isEmpty {
                inMoves = true
            } else if inMoves {
                moveText += trimmed + " "
            }
        }

        var moves: [String] = []
        let tokens = moveText.split(separator: " ").map(String.init)
        for token in tokens {
            if token.contains("-") && !token.hasSuffix(".") {
                moves.append(token)
            }
        }

        return HnefataflPGN(headers: headers, moves: moves)
    }

    private static func resultString(_ status: GameStatus) -> String {
        switch status {
        case .attackerWins: return "1-0"
        case .defenderWins: return "0-1"
        case .draw: return "1/2-1/2"
        case .inProgress: return "*"
        }
    }
}

private extension Character {
    var isWhitespaceOrNewline: Bool {
        self == " " || self == "\t" || self == "\n" || self == "\r"
    }
}
