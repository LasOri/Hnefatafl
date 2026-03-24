struct PositionSerializer {
    static func serialize(position: Position) -> String {
        position.cells.map { cell -> String in
            switch cell {
            case .attacker: return "A"
            case .defender: return "D"
            case .king: return "K"
            case nil: return "."
            }
        }.joined()
    }

    static func deserialize(_ string: String) -> Position? {
        let chars = Array(string)
        guard chars.count == Position.boardSize * Position.boardSize else { return nil }

        var cells: [Piece?] = []
        for char in chars {
            switch char {
            case "A": cells.append(.attacker)
            case "D": cells.append(.defender)
            case "K": cells.append(.king)
            case ".": cells.append(nil)
            default: return nil
            }
        }

        return Position(cells: cells)
    }
}
