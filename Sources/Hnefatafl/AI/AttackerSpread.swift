
#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

enum AttackerSpread {
    static func variance(position: Position) -> Double {
        var rows: [Int] = []
        var cols: [Int] = []
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .attacker {
                    rows.append(row)
                    cols.append(col)
                }
            }
        }
        guard !rows.isEmpty else { return 0 }
        let rowVar = varianceOf(rows)
        let colVar = varianceOf(cols)
        return (rowVar + colVar) / 2
    }

    private static func varianceOf(_ values: [Int]) -> Double {
        let mean = Double(values.reduce(0, +)) / Double(values.count)
        let sumSq = values.map { pow(Double($0) - mean, 2) }.reduce(0, +)
        return sumSq / Double(values.count)
    }

    static func isConcentrated(position: Position, threshold: Double = 5) -> Bool {
        variance(position: position) < threshold
    }
}
