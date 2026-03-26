struct CaptureRiskEntry: Equatable {
    let row: Int
    let col: Int
    let riskLevel: Int
}

enum CaptureRisk {
    static func assess(position: Position, for player: Player) -> [CaptureRiskEntry] {
        var results: [CaptureRiskEntry] = []

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                let piece = position.pieceAt(row: row, col: col)
                let isFriendly: Bool
                if player == .attacker {
                    isFriendly = piece == .attacker
                } else {
                    isFriendly = piece == .defender || piece == .king
                }
                guard isFriendly else { continue }

                var risk = 0
                let adjacent = [(-1, 0), (1, 0), (0, -1), (0, 1)]
                for dir in adjacent {
                    let r = row + dir.0
                    let c = col + dir.1
                    guard r >= 0, r < Position.boardSize, c >= 0, c < Position.boardSize else {
                        risk += 1
                        continue
                    }
                    let adj = position.pieceAt(row: r, col: c)
                    if player == .attacker && (adj == .defender || adj == .king) {
                        risk += 1
                    } else if player == .defender && adj == .attacker {
                        risk += 1
                    }
                }

                results.append(CaptureRiskEntry(row: row, col: col, riskLevel: risk))
            }
        }

        return results
    }
}
