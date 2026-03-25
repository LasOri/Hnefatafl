struct EdgeControl: Equatable {
    let top: Int
    let bottom: Int
    let left: Int
    let right: Int

    var dominantEdge: Int {
        max(top, bottom, left, right)
    }

    var totalControl: Int {
        top + bottom + left + right
    }
}

enum BoardEdgeControl {
    static func edgeControl(position: Position, player: Player) -> EdgeControl {
        var top = 0
        var bottom = 0
        var left = 0
        var right = 0

        for col in 0..<Position.boardSize {
            if let piece = position.pieceAt(row: 0, col: col) {
                if piecePlayer(piece) == player {
                    top += 1
                }
            }

            if let piece = position.pieceAt(row: Position.boardSize - 1, col: col) {
                if piecePlayer(piece) == player {
                    bottom += 1
                }
            }
        }

        for row in 0..<Position.boardSize {
            if let piece = position.pieceAt(row: row, col: 0) {
                if piecePlayer(piece) == player {
                    left += 1
                }
            }

            if let piece = position.pieceAt(row: row, col: Position.boardSize - 1) {
                if piecePlayer(piece) == player {
                    right += 1
                }
            }
        }

        return EdgeControl(top: top, bottom: bottom, left: left, right: right)
    }

    private static func piecePlayer(_ piece: Piece) -> Player {
        switch piece {
        case .attacker:
            return .attacker
        case .defender, .king:
            return .defender
        }
    }
}
