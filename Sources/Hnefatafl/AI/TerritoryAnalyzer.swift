struct TerritoryAnalyzer {
    static func analyze(position: Position) -> [Double] {
        let size = Position.boardSize
        var control = Array(repeating: 0.0, count: size * size)

        for row in 0..<size {
            for col in 0..<size {
                guard let piece = position.pieceAt(row: row, col: col) else { continue }
                let sign: Double = piece.isAttackerSide ? 1.0 : -1.0

                for r in 0..<size {
                    for c in 0..<size {
                        let distance = abs(r - row) + abs(c - col)
                        let influence = 1.0 / (1.0 + Double(distance))
                        control[r * size + c] += sign * influence
                    }
                }
            }
        }

        let maxVal = control.map { abs($0) }.max() ?? 1.0
        guard maxVal > 0 else { return control }
        return control.map { $0 / maxVal }
    }

    static func attackerPercentage(position: Position) -> Int {
        let control = analyze(position: position)
        let attackerSquares = control.filter { $0 > 0.05 }.count
        let total = control.count
        return Int(Double(attackerSquares) / Double(total) * 100.0)
    }
}
