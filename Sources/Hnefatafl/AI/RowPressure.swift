struct RowPressureEntry: Equatable {
    let row: Int
    let pressure: Int
}

enum RowPressure {
    static func evaluate(position: Position, for player: Player) -> [RowPressureEntry] {
        var results: [RowPressureEntry] = []

        for row in 0..<Position.boardSize {
            var pressure = 0
            for col in 0..<Position.boardSize {
                let piece = position.pieceAt(row: row, col: col)
                if player == .attacker && piece == .attacker {
                    pressure += 1
                } else if player == .defender && (piece == .defender || piece == .king) {
                    pressure += 1
                }
            }
            results.append(RowPressureEntry(row: row, pressure: pressure))
        }

        return results
    }
}
