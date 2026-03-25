enum ShieldWallEval {
    static func shieldWallThreats(position: Position) -> Int {
        var threats = 0
        threats += countEdgeThreats(position: position, edge: .top)
        threats += countEdgeThreats(position: position, edge: .bottom)
        threats += countEdgeThreats(position: position, edge: .left)
        threats += countEdgeThreats(position: position, edge: .right)
        return threats
    }

    static func hasShieldWallOpportunity(position: Position) -> Bool {
        shieldWallThreats(position: position) > 0
    }

    private enum Edge {
        case top, bottom, left, right
    }

    private static func countEdgeThreats(position: Position, edge: Edge) -> Int {
        let size = Position.boardSize
        var threats = 0

        for i in 1..<(size - 1) {
            let (row, col) = edgeCoord(edge: edge, index: i)
            let piece = position.pieceAt(row: row, col: col)
            guard piece == .defender || piece == .king else { continue }

            let (behindRow, behindCol) = behindCoord(edge: edge, row: row, col: col)
            guard behindRow >= 0 && behindRow < size && behindCol >= 0 && behindCol < size else { continue }
            let behind = position.pieceAt(row: behindRow, col: behindCol)
            guard behind == .attacker else { continue }

            let (leftRow, leftCol) = adjacentAlongEdge(edge: edge, row: row, col: col, offset: -1)
            let (rightRow, rightCol) = adjacentAlongEdge(edge: edge, row: row, col: col, offset: 1)

            let leftBlocked = leftRow < 0 || leftCol < 0 || leftRow >= size || leftCol >= size
                || position.pieceAt(row: leftRow, col: leftCol) == .attacker
            let rightBlocked = rightRow < 0 || rightCol < 0 || rightRow >= size || rightCol >= size
                || position.pieceAt(row: rightRow, col: rightCol) == .attacker

            if leftBlocked && rightBlocked {
                threats += 1
            }
        }
        return threats
    }

    private static func edgeCoord(edge: Edge, index: Int) -> (Int, Int) {
        switch edge {
        case .top: return (0, index)
        case .bottom: return (10, index)
        case .left: return (index, 0)
        case .right: return (index, 10)
        }
    }

    private static func behindCoord(edge: Edge, row: Int, col: Int) -> (Int, Int) {
        switch edge {
        case .top: return (row + 1, col)
        case .bottom: return (row - 1, col)
        case .left: return (row, col + 1)
        case .right: return (row, col - 1)
        }
    }

    private static func adjacentAlongEdge(edge: Edge, row: Int, col: Int, offset: Int) -> (Int, Int) {
        switch edge {
        case .top, .bottom: return (row, col + offset)
        case .left, .right: return (row + offset, col)
        }
    }
}
