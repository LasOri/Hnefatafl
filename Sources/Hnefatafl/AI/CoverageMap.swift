struct CoverageMap: Equatable {
    let coverage: [Int]

    func value(row: Int, col: Int) -> Int {
        coverage[row * Position.boardSize + col]
    }

    var maxCoverage: Int {
        coverage.max() ?? 0
    }
}

enum CoverageMapBuilder {
    static func build(position: Position, player: Player) -> CoverageMap {
        var cov = Array(repeating: 0, count: Position.boardSize * Position.boardSize)
        let moves = position.allLegalMoves(for: player)
        for move in moves {
            cov[move.toRow * Position.boardSize + move.toCol] += 1
        }
        return CoverageMap(coverage: cov)
    }
}
