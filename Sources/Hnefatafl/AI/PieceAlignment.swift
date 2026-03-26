enum AlignmentAxis: Equatable {
    case row
    case column
}

struct AlignmentEntry: Equatable {
    let axis: AlignmentAxis
    let index: Int
    let count: Int
}

enum PieceAlignment {
    static func detect(position: Position, for player: Player) -> [AlignmentEntry] {
        var rowCounts = Array(repeating: 0, count: Position.boardSize)
        var colCounts = Array(repeating: 0, count: Position.boardSize)

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                let piece = position.pieceAt(row: row, col: col)
                let isFriendly: Bool
                if player == .attacker {
                    isFriendly = piece == .attacker
                } else {
                    isFriendly = piece == .defender || piece == .king
                }
                if isFriendly {
                    rowCounts[row] += 1
                    colCounts[col] += 1
                }
            }
        }

        var results: [AlignmentEntry] = []
        for i in 0..<Position.boardSize {
            if rowCounts[i] >= 2 {
                results.append(AlignmentEntry(axis: .row, index: i, count: rowCounts[i]))
            }
            if colCounts[i] >= 2 {
                results.append(AlignmentEntry(axis: .column, index: i, count: colCounts[i]))
            }
        }

        return results
    }
}
