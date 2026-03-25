enum NetControlDelta {
    static func delta(before: Position, after: Position) -> Int {
        let controlBefore = netControl(position: before)
        let controlAfter = netControl(position: after)
        return controlAfter - controlBefore
    }

    static func isImproving(before: Position, after: Position, player: Player) -> Bool {
        let d = delta(before: before, after: after)
        switch player {
        case .attacker:
            return d > 0
        case .defender:
            return d < 0
        }
    }

    private static func netControl(position: Position) -> Int {
        var attackerControl = 0
        var defenderControl = 0

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == nil {
                    let attackerInfluence = countInfluence(row: row, col: col, position: position, isAttacker: true)
                    let defenderInfluence = countInfluence(row: row, col: col, position: position, isAttacker: false)
                    if attackerInfluence > defenderInfluence {
                        attackerControl += 1
                    } else if defenderInfluence > attackerInfluence {
                        defenderControl += 1
                    }
                }
            }
        }

        return attackerControl - defenderControl
    }

    private static func countInfluence(row: Int, col: Int, position: Position, isAttacker: Bool) -> Int {
        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        var influence = 0

        for dir in directions {
            var r = row + dir.0
            var c = col + dir.1
            while r >= 0 && r < Position.boardSize && c >= 0 && c < Position.boardSize {
                let piece = position.pieceAt(row: r, col: c)
                if let piece = piece {
                    if isAttacker && piece == .attacker {
                        influence += 1
                    } else if !isAttacker && (piece == .defender || piece == .king) {
                        influence += 1
                    }
                    break
                }
                r += dir.0
                c += dir.1
            }
        }

        return influence
    }
}
