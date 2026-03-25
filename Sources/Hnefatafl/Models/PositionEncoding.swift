enum PositionEncoding {
    static func encode(_ position: Position) -> String {
        var result = ""
        var emptyCount = 0

        for i in 0..<121 {
            let row = i / 11
            let col = i % 11
            let piece = position.pieceAt(row: row, col: col)

            if piece == nil {
                emptyCount += 1
            } else {
                if emptyCount > 0 {
                    result += String(emptyCount)
                    emptyCount = 0
                }
                switch piece {
                case .attacker: result += "A"
                case .defender: result += "D"
                case .king: result += "K"
                case .none: break
                }
            }

            if col == 10 && i < 120 {
                if emptyCount > 0 {
                    result += String(emptyCount)
                    emptyCount = 0
                }
                result += "/"
            }
        }

        if emptyCount > 0 {
            result += String(emptyCount)
        }

        return result
    }

    static func decode(_ encoded: String) -> Position? {
        guard !encoded.isEmpty else { return nil }

        var cells: [Piece?] = []
        var numberBuffer = ""

        for char in encoded {
            if char == "/" {
                if !numberBuffer.isEmpty {
                    guard let count = Int(numberBuffer) else { return nil }
                    cells.append(contentsOf: Array(repeating: nil as Piece?, count: count))
                    numberBuffer = ""
                }
            } else if char.isNumber {
                numberBuffer.append(char)
            } else {
                if !numberBuffer.isEmpty {
                    guard let count = Int(numberBuffer) else { return nil }
                    cells.append(contentsOf: Array(repeating: nil as Piece?, count: count))
                    numberBuffer = ""
                }
                switch char {
                case "A": cells.append(.attacker)
                case "D": cells.append(.defender)
                case "K": cells.append(.king)
                default: return nil
                }
            }
        }

        if !numberBuffer.isEmpty {
            guard let count = Int(numberBuffer) else { return nil }
            cells.append(contentsOf: Array(repeating: nil as Piece?, count: count))
        }

        guard cells.count == 121 else { return nil }
        return Position(cells: cells)
    }
}
