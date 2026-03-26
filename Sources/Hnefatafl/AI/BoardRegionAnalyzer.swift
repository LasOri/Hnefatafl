struct RegionInfo: Equatable {
    let name: String
    let attackerCount: Int
    let defenderCount: Int
}

struct BoardAnalysisResult: Equatable {
    let regions: [RegionInfo]

    var mostContested: RegionInfo? {
        regions.max(by: { min($0.attackerCount, $0.defenderCount) < min($1.attackerCount, $1.defenderCount) })
    }
}

enum BoardRegionAnalyzer {
    static func analyze(position: Position) -> BoardAnalysisResult {
        let mid = Position.boardSize / 2
        let quadrants: [(String, ClosedRange<Int>, ClosedRange<Int>)] = [
            ("NW", 0...mid, 0...mid),
            ("NE", 0...mid, (mid)...Position.boardSize - 1),
            ("SW", (mid)...Position.boardSize - 1, 0...mid),
            ("SE", (mid)...Position.boardSize - 1, (mid)...Position.boardSize - 1),
        ]

        var regions: [RegionInfo] = []
        for (name, rowRange, colRange) in quadrants {
            var attackers = 0
            var defenders = 0
            for row in rowRange {
                for col in colRange {
                    switch position.pieceAt(row: row, col: col) {
                    case .attacker: attackers += 1
                    case .defender, .king: defenders += 1
                    case nil: break
                    }
                }
            }
            regions.append(RegionInfo(name: name, attackerCount: attackers, defenderCount: defenders))
        }

        return BoardAnalysisResult(regions: regions)
    }
}
