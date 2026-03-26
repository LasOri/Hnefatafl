enum MotifType: Equatable {
    case fork
    case confinement
    case escape
}

struct TacticalMotifEntry: Equatable {
    let type: MotifType
    let description: String
}

enum TacticalMotif {
    static func detect(position: Position, player: Player) -> [TacticalMotifEntry] {
        var motifs: [TacticalMotifEntry] = []

        if player == .attacker {
            if detectConfinement(position: position) {
                motifs.append(TacticalMotifEntry(type: .confinement, description: "King confined to few squares"))
            }
        }

        if player == .defender {
            if detectEscape(position: position) {
                motifs.append(TacticalMotifEntry(type: .escape, description: "King has path to corner"))
            }
        }

        return motifs
    }

    private static func detectConfinement(position: Position) -> Bool {
        var kingRow = -1, kingCol = -1
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .king {
                    kingRow = row
                    kingCol = col
                }
            }
        }
        guard kingRow >= 0 else { return false }

        let kingMoves = position.allLegalMoves(for: .defender).filter { $0.fromRow == kingRow && $0.fromCol == kingCol }
        return kingMoves.count <= 2
    }

    private static func detectEscape(position: Position) -> Bool {
        var kingRow = -1, kingCol = -1
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .king {
                    kingRow = row
                    kingCol = col
                }
            }
        }
        guard kingRow >= 0 else { return false }

        let corners = [(0, 0), (0, 10), (10, 0), (10, 10)]
        let kingMoves = position.allLegalMoves(for: .defender).filter { $0.fromRow == kingRow && $0.fromCol == kingCol }
        for move in kingMoves {
            if corners.contains(where: { $0.0 == move.toRow && $0.1 == move.toCol }) {
                return true
            }
        }

        for corner in corners {
            let dist = abs(kingRow - corner.0) + abs(kingCol - corner.1)
            if dist <= 2 {
                let onSameRow = kingRow == corner.0
                let onSameCol = kingCol == corner.1
                if onSameRow || onSameCol { return true }
            }
        }

        return false
    }
}
