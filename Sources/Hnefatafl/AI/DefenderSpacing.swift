
#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

enum DefenderSpacing {
    static func spacingScore(position: Position) -> Int {
        let king = findKing(position: position)
        guard let king = king else { return 0 }

        let defenders = findDefenders(position: position)
        guard defenders.count >= 2 else { return 0 }

        let angles = defenders.map { def in
            atan2(Double(def.row - king.row), Double(def.col - king.col))
        }.sorted()

        let uniqueAngles = deduplicateAngles(angles)
        guard uniqueAngles.count >= 2 else { return 0 }

        var gaps: [Double] = []
        for i in 0..<uniqueAngles.count {
            let next = (i + 1) % uniqueAngles.count
            var gap = uniqueAngles[next] - uniqueAngles[i]
            if gap <= 0 { gap += 2 * Double.pi }
            gaps.append(gap)
        }

        let idealGap = (2 * Double.pi) / Double(uniqueAngles.count)
        let deviation = gaps.reduce(0.0) { sum, gap in
            sum + abs(gap - idealGap)
        }

        let maxDeviation = 2 * Double.pi
        let normalizedScore = max(0, Int((1.0 - deviation / maxDeviation) * 100))
        return normalizedScore
    }

    static func maxGap(position: Position) -> Int {
        let king = findKing(position: position)
        guard let king = king else { return 360 }

        let defenders = findDefenders(position: position)
        guard defenders.count >= 2 else { return 360 }

        let angles = defenders.map { def in
            atan2(Double(def.row - king.row), Double(def.col - king.col))
        }.sorted()

        let uniqueAngles = deduplicateAngles(angles)
        guard uniqueAngles.count >= 2 else { return 360 }

        var largest = 0.0
        for i in 0..<uniqueAngles.count {
            let next = (i + 1) % uniqueAngles.count
            var gap = uniqueAngles[next] - uniqueAngles[i]
            if gap <= 0 { gap += 2 * Double.pi }
            if gap > largest { largest = gap }
        }

        return Int(largest * 180.0 / Double.pi)
    }

    private static func findKing(position: Position) -> (row: Int, col: Int)? {
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .king {
                    return (row, col)
                }
            }
        }
        return nil
    }

    private static func deduplicateAngles(_ sorted: [Double]) -> [Double] {
        guard !sorted.isEmpty else { return [] }
        var result = [sorted[0]]
        for i in 1..<sorted.count {
            if abs(sorted[i] - result.last!) > 0.001 {
                result.append(sorted[i])
            }
        }
        return result
    }

    private static func findDefenders(position: Position) -> [(row: Int, col: Int)] {
        var result: [(row: Int, col: Int)] = []
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .defender {
                    result.append((row, col))
                }
            }
        }
        return result
    }
}
