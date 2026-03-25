enum AnchorSquare {
    static func anchors(position: Position, player: Player) -> [(row: Int, col: Int)] {
        var result: [(row: Int, col: Int)] = []
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard let piece = position.pieceAt(row: row, col: col) else { continue }
                guard belongsTo(piece: piece, player: player) else { continue }
                if isAnchor(row: row, col: col, position: position, player: player) {
                    result.append((row, col))
                }
            }
        }
        return result
    }

    static func anchorCount(position: Position, player: Player) -> Int {
        anchors(position: position, player: player).count
    }

    private static func isAnchor(row: Int, col: Int, position: Position, player: Player) -> Bool {
        let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]
        var supportCount = 0
        for (dr, dc) in directions {
            let r = row + dr
            let c = col + dc
            guard r >= 0 && r < Position.boardSize && c >= 0 && c < Position.boardSize else {
                supportCount += 1
                continue
            }
            if let neighbor = position.pieceAt(row: r, col: c) {
                if belongsTo(piece: neighbor, player: player) { supportCount += 1 }
            }
            let squareType = Position.squareType(row: r, col: c)
            if squareType == .corner || squareType == .throne {
                supportCount += 1
            }
        }
        return supportCount >= 2
    }

    private static func belongsTo(piece: Piece, player: Player) -> Bool {
        switch piece {
        case .attacker: return player == .attacker
        case .defender, .king: return player == .defender
        }
    }
}
