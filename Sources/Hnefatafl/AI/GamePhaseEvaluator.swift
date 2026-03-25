struct PhaseWeights: Equatable {
    let material: Int
    let mobility: Int
    let kingDistance: Int
}

enum GamePhaseEvaluator {
    static func evaluateForPhase(position: Position, player: Player) -> Int {
        let phase = EndgameDetector.phase(position: position)
        let weights = phaseWeight(phase)

        let materialScore = calculateMaterial(position: position, player: player) * weights.material
        let mobilityScore = calculateMobility(position: position, player: player) * weights.mobility
        let kingScore = calculateKingDistance(position: position, player: player) * weights.kingDistance

        return materialScore + mobilityScore + kingScore
    }

    static func phaseWeight(_ phase: GamePhase) -> PhaseWeights {
        switch phase {
        case .opening:
            return PhaseWeights(material: 10, mobility: 5, kingDistance: 3)
        case .midgame:
            return PhaseWeights(material: 8, mobility: 7, kingDistance: 5)
        case .endgame:
            return PhaseWeights(material: 5, mobility: 10, kingDistance: 8)
        }
    }

    private static func calculateMaterial(position: Position, player: Player) -> Int {
        switch player {
        case .attacker:
            return position.attackerCount - position.defenderCount
        case .defender:
            return position.defenderCount - position.attackerCount
        }
    }

    private static func calculateMobility(position: Position, player: Player) -> Int {
        return position.allLegalMoves(for: player).count
    }

    private static func calculateKingDistance(position: Position, player: Player) -> Int {
        guard let kingPos = findKing(position: position) else {
            return 0
        }

        let cornerDistance = minCornerDistance(row: kingPos.row, col: kingPos.col)

        switch player {
        case .attacker:
            return -cornerDistance
        case .defender:
            return cornerDistance
        }
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
        let corners = [(0, 0), (0, Position.boardSize - 1), (Position.boardSize - 1, 0), (Position.boardSize - 1, Position.boardSize - 1)]
        return corners.map { abs(row - $0.0) + abs(col - $0.1) }.min() ?? 0
    }
}
