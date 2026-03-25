enum PlanType: String, Equatable {
    case kingHunt
    case cornerBlock
    case materialGain
    case consolidate
}

enum StrategicPlan {
    static func suggestPlan(position: Position, player: Player) -> PlanType {
        switch player {
        case .attacker:
            return suggestAttackerPlan(position: position)
        case .defender:
            return suggestDefenderPlan(position: position)
        }
    }

    private static func suggestAttackerPlan(position: Position) -> PlanType {
        let kingPos = findKing(position: position)
        if let kp = kingPos {
            let cornerDist = minCornerDistance(row: kp.row, col: kp.col)
            if cornerDist <= 3 {
                return .cornerBlock
            }
        }

        let defenderCount = position.defenderCount
        let attackerCount = position.attackerCount
        if attackerCount > defenderCount + 4 {
            return .kingHunt
        }

        let captures = captureOpportunityCount(position: position, player: .attacker)
        if captures > 0 {
            return .materialGain
        }

        return .consolidate
    }

    private static func suggestDefenderPlan(position: Position) -> PlanType {
        let kingPos = findKing(position: position)
        if let kp = kingPos {
            let cornerDist = minCornerDistance(row: kp.row, col: kp.col)
            if cornerDist <= 4 {
                return .kingHunt
            }
        }

        let captures = captureOpportunityCount(position: position, player: .defender)
        if captures > 0 {
            return .materialGain
        }

        return .consolidate
    }

    private static func findKing(position: Position) -> (row: Int, col: Int)? {
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .king {
                    return (row, col)
                }
            }
        }
        return nil
    }

    private static func minCornerDistance(row: Int, col: Int) -> Int {
        let last = Position.boardSize - 1
        let corners = [(0, 0), (0, last), (last, 0), (last, last)]
        var minDist = Int.max
        for (cr, cc) in corners {
            let dist = abs(row - cr) + abs(col - cc)
            if dist < minDist { minDist = dist }
        }
        return minDist
    }

    private static func captureOpportunityCount(position: Position, player: Player) -> Int {
        let moves = position.allLegalMoves(for: player)
        var count = 0
        let opponent: Player = player == .attacker ? .defender : .attacker
        for move in moves {
            let after = position.applyMove(move)
            let before = countFor(position: position, player: opponent)
            let afterCount = countFor(position: after, player: opponent)
            if afterCount < before { count += 1 }
        }
        return count
    }

    private static func countFor(position: Position, player: Player) -> Int {
        switch player {
        case .attacker: return position.attackerCount
        case .defender: return position.defenderCount
        }
    }
}
