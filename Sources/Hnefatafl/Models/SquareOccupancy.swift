struct OccupancyEntry: Equatable {
    let row: Int
    let col: Int
    let count: Int
}

struct SquareOccupancyTracker: Equatable {
    private var counts: [Int]

    init() {
        counts = Array(repeating: 0, count: 121)
    }

    func count(row: Int, col: Int) -> Int {
        counts[row * 11 + col]
    }

    var mostOccupied: OccupancyEntry? {
        guard let maxIdx = counts.enumerated().max(by: { $0.element < $1.element }),
              maxIdx.element > 0 else { return nil }
        return OccupancyEntry(row: maxIdx.offset / 11, col: maxIdx.offset % 11, count: maxIdx.element)
    }

    func heatmap() -> [[Int]] {
        (0..<11).map { row in
            (0..<11).map { col in counts[row * 11 + col] }
        }
    }

    mutating func record(position: Position) {
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) != nil {
                    counts[row * 11 + col] += 1
                }
            }
        }
    }

    mutating func clear() {
        counts = Array(repeating: 0, count: 121)
    }
}
