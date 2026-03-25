enum GapAnalysis {
    static func gapCount(position: Position) -> Int {
        let edgeAttackers = findEdgeAttackers(position: position)
        if edgeAttackers.isEmpty { return 4 }

        var gaps = 0
        let perimeter = buildPerimeter()

        var inGap = false
        for (row, col) in perimeter {
            if position.pieceAt(row: row, col: col) == .attacker {
                if inGap {
                    gaps += 1
                    inGap = false
                }
            } else {
                inGap = true
            }
        }

        if inGap {
            gaps += 1
        }

        return gaps
    }

    static func largestGap(position: Position) -> Int {
        let perimeter = buildPerimeter()
        var maxGap = 0
        var currentGap = 0

        for (row, col) in perimeter {
            if position.pieceAt(row: row, col: col) == .attacker {
                if currentGap > maxGap {
                    maxGap = currentGap
                }
                currentGap = 0
            } else {
                currentGap += 1
            }
        }

        if currentGap > maxGap {
            maxGap = currentGap
        }

        return maxGap
    }

    private static func findEdgeAttackers(position: Position) -> [(Int, Int)] {
        var result: [(Int, Int)] = []
        let last = Position.boardSize - 1

        for i in 0..<Position.boardSize {
            if position.pieceAt(row: 0, col: i) == .attacker { result.append((0, i)) }
            if position.pieceAt(row: last, col: i) == .attacker { result.append((last, i)) }
            if i > 0 && i < last {
                if position.pieceAt(row: i, col: 0) == .attacker { result.append((i, 0)) }
                if position.pieceAt(row: i, col: last) == .attacker { result.append((i, last)) }
            }
        }

        return result
    }

    private static func buildPerimeter() -> [(Int, Int)] {
        let last = Position.boardSize - 1
        var perimeter: [(Int, Int)] = []

        for col in 0...last { perimeter.append((0, col)) }
        for row in 1...last { perimeter.append((row, last)) }
        for col in stride(from: last - 1, through: 0, by: -1) { perimeter.append((last, col)) }
        for row in stride(from: last - 1, through: 1, by: -1) { perimeter.append((row, 0)) }

        return perimeter
    }
}
