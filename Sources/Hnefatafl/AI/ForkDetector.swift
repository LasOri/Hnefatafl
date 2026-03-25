enum ForkDetector {
    static func detectForks(position: Position, player: Player) -> [Move] {
        let moves = position.allLegalMoves(for: player)
        var forks: [Move] = []
        for move in moves {
            let after = position.applyMove(move)
            let threatened = threatenedEnemyCount(position: after, row: move.toRow, col: move.toCol, player: player)
            if threatened >= 2 { forks.append(move) }
        }
        return forks
    }

    static func forkCount(position: Position, player: Player) -> Int {
        detectForks(position: position, player: player).count
    }

    private static func threatenedEnemyCount(position: Position, row: Int, col: Int, player: Player) -> Int {
        var count = 0
        let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]
        for (dr, dc) in directions {
            let neighborRow = row + dr
            let neighborCol = col + dc
            let beyondRow = row + dr * 2
            let beyondCol = col + dc * 2
            guard isInBounds(row: neighborRow, col: neighborCol) else { continue }
            guard let neighbor = position.pieceAt(row: neighborRow, col: neighborCol) else { continue }
            if neighbor == .king { continue }
            let isEnemy: Bool
            switch player {
            case .attacker: isEnemy = neighbor.isDefenderSide
            case .defender: isEnemy = neighbor.isAttackerSide
            }
            guard isEnemy else { continue }
            if isInBounds(row: beyondRow, col: beyondCol) {
                if let beyond = position.pieceAt(row: beyondRow, col: beyondCol) {
                    let isAlly: Bool
                    switch player {
                    case .attacker: isAlly = beyond.isAttackerSide
                    case .defender: isAlly = beyond.isDefenderSide
                    }
                    if isAlly { count += 1; continue }
                }
                let squareType = Position.squareType(row: beyondRow, col: beyondCol)
                if squareType == .corner || (squareType == .throne && position.pieceAt(row: beyondRow, col: beyondCol) == nil) {
                    count += 1
                }
            }
        }
        return count
    }

    private static func isInBounds(row: Int, col: Int) -> Bool {
        row >= 0 && row < Position.boardSize && col >= 0 && col < Position.boardSize
    }
}
