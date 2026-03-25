enum TempoCounter {
    static func tempoCount(position: Position, player: Player) -> Int {
        var count = 0
        let isAttacker = player == .attacker
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                let piece = position.pieceAt(row: row, col: col)
                guard let piece = piece else { continue }
                let belongs: Bool
                switch piece {
                case .attacker: belongs = isAttacker
                case .defender, .king: belongs = !isAttacker
                }
                guard belongs else { continue }
                let advancement: Int
                if isAttacker {
                    let distToCenter = abs(row - 5) + abs(col - 5)
                    advancement = max(0, 10 - distToCenter)
                } else {
                    let distToNearestCorner = min(
                        row + col,
                        row + (10 - col),
                        (10 - row) + col,
                        (10 - row) + (10 - col)
                    )
                    advancement = max(0, 10 - distToNearestCorner)
                }
                count += advancement
            }
        }
        return count
    }

    static func tempoLead(position: Position) -> Int {
        let attackerTempo = tempoCount(position: position, player: .attacker)
        let defenderTempo = tempoCount(position: position, player: .defender)
        return attackerTempo - defenderTempo
    }
}
