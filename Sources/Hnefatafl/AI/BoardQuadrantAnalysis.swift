struct QuadrantCounts: Equatable {
    let topLeft: Int
    let topRight: Int
    let bottomLeft: Int
    let bottomRight: Int
}

enum BoardQuadrantAnalysis {
    static func analyze(position: Position, player: Player) -> QuadrantCounts {
        let mid = Position.boardSize / 2
        var topLeft = 0
        var topRight = 0
        var bottomLeft = 0
        var bottomRight = 0

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if let piece = position.pieceAt(row: row, col: col) {
                    let piecePlayer: Player
                    switch piece {
                    case .attacker:
                        piecePlayer = .attacker
                    case .defender, .king:
                        piecePlayer = .defender
                    }

                    if piecePlayer == player {
                        if row < mid && col < mid {
                            topLeft += 1
                        } else if row < mid && col >= mid {
                            topRight += 1
                        } else if row >= mid && col < mid {
                            bottomLeft += 1
                        } else {
                            bottomRight += 1
                        }
                    }
                }
            }
        }

        return QuadrantCounts(
            topLeft: topLeft,
            topRight: topRight,
            bottomLeft: bottomLeft,
            bottomRight: bottomRight
        )
    }
}
