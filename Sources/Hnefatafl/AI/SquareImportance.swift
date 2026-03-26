struct ImportanceEntry: Equatable {
    let row: Int
    let col: Int
    let importance: Int
}

enum SquareImportance {
    static func score(row: Int, col: Int) -> Int {
        var importance = 1

        let corners = [(0, 0), (0, 10), (10, 0), (10, 10)]
        if corners.contains(where: { $0.0 == row && $0.1 == col }) {
            importance += 10
        }

        if row == 5 && col == 5 {
            importance += 8
        }

        let minCornerDist = corners.map { abs($0.0 - row) + abs($0.1 - col) }.min() ?? 20
        if minCornerDist <= 2 {
            importance += 5
        }

        if row == 0 || row == 10 || col == 0 || col == 10 {
            importance += 2
        }

        return importance
    }

    static func ranking() -> [ImportanceEntry] {
        var entries: [ImportanceEntry] = []
        for row in 0..<11 {
            for col in 0..<11 {
                entries.append(ImportanceEntry(row: row, col: col, importance: score(row: row, col: col)))
            }
        }
        entries.sort { $0.importance > $1.importance }
        return entries
    }
}
