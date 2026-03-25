enum BoardSectorType: String, CaseIterable, Equatable {
    case center
    case edge
    case corner
}

enum BoardSector {
    static func sector(row: Int, col: Int) -> BoardSectorType {
        let isRowEdge = row == 0 || row == Position.boardSize - 1
        let isColEdge = col == 0 || col == Position.boardSize - 1
        if isRowEdge && isColEdge { return .corner }
        if isRowEdge || isColEdge { return .edge }
        return .center
    }

    static func pieceCountBySector(position: Position, player: Player) -> [BoardSectorType: Int] {
        var counts: [BoardSectorType: Int] = [.center: 0, .edge: 0, .corner: 0]
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard let piece = position.pieceAt(row: row, col: col) else { continue }
                let belongs: Bool
                switch player {
                case .attacker: belongs = piece.isAttackerSide
                case .defender: belongs = piece.isDefenderSide
                }
                guard belongs else { continue }
                let s = sector(row: row, col: col)
                counts[s, default: 0] += 1
            }
        }
        return counts
    }
}
