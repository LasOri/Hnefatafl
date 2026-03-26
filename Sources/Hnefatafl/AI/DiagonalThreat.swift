struct DiagonalThreatEntry: Equatable {
    let targetRow: Int
    let targetCol: Int
}

enum DiagonalThreat {
    static func detect(position: Position, for player: Player) -> [DiagonalThreatEntry] {
        var threats: [DiagonalThreatEntry] = []
        let offsets = [(-1, -1), (-1, 1), (1, -1), (1, 1)]

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                let piece = position.pieceAt(row: row, col: col)
                guard piece != nil else { continue }

                let isEnemy: Bool
                if player == .attacker {
                    isEnemy = (piece == .defender || piece == .king)
                } else {
                    isEnemy = (piece == .attacker)
                }
                guard isEnemy else { continue }

                var diagonalFriendCount = 0
                for offset in offsets {
                    let r = row + offset.0
                    let c = col + offset.1
                    guard r >= 0, r < Position.boardSize, c >= 0, c < Position.boardSize else { continue }
                    let adj = position.pieceAt(row: r, col: c)
                    if player == .attacker && adj == .attacker { diagonalFriendCount += 1 }
                    if player == .defender && (adj == .defender || adj == .king) { diagonalFriendCount += 1 }
                }

                if diagonalFriendCount >= 2 {
                    let entry = DiagonalThreatEntry(targetRow: row, targetCol: col)
                    if !threats.contains(entry) {
                        threats.append(entry)
                    }
                }
            }
        }

        return threats
    }
}
