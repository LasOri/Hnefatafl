struct ColumnPressureEntry: Equatable {
    let column: Int
    let pressure: Int
}

enum ColumnPressure {
    static func evaluate(position: Position, for player: Player) -> [ColumnPressureEntry] {
        var results: [ColumnPressureEntry] = []

        for col in 0..<Position.boardSize {
            var pressure = 0
            for row in 0..<Position.boardSize {
                let piece = position.pieceAt(row: row, col: col)
                if player == .attacker && piece == .attacker {
                    pressure += 1
                } else if player == .defender && (piece == .defender || piece == .king) {
                    pressure += 1
                }
            }
            results.append(ColumnPressureEntry(column: col, pressure: pressure))
        }

        return results
    }
}
