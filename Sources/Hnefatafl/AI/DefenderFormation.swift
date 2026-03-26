enum FormationType: Equatable {
    case diamond
    case fortress
    case scattered
    case none
}

enum DefenderFormation {
    static func classify(position: Position) -> FormationType {
        var kingRow = -1
        var kingCol = -1
        var defenderPositions: [(Int, Int)] = []

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                switch position.pieceAt(row: row, col: col) {
                case .king:
                    kingRow = row
                    kingCol = col
                case .defender:
                    defenderPositions.append((row, col))
                default: break
                }
            }
        }

        guard kingRow >= 0 else { return .none }
        guard !defenderPositions.isEmpty else { return .none }

        let distances = defenderPositions.map { abs($0.0 - kingRow) + abs($0.1 - kingCol) }
        let avgDistance = Double(distances.reduce(0, +)) / Double(distances.count)

        let adjacentCount = defenderPositions.filter { abs($0.0 - kingRow) + abs($0.1 - kingCol) == 1 }.count

        if adjacentCount >= 4 && defenderPositions.count <= 5 { return .fortress }
        if avgDistance <= 3.0 && defenderPositions.count >= 4 { return .diamond }
        return .scattered
    }
}
