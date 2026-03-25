struct PieceSelectionInfo: Equatable {
    let row: Int
    let col: Int
    let piece: Piece
    let moveCount: Int
    let canSelect: Bool
}

enum PieceSelectorHelper {
    static func info(row: Int, col: Int, position: Position, currentPlayer: Player) -> PieceSelectionInfo? {
        guard let piece = position.pieceAt(row: row, col: col) else { return nil }
        let piecePlayer: Player
        switch piece {
        case .attacker: piecePlayer = .attacker
        case .defender, .king: piecePlayer = .defender
        }
        let moves = position.legalMoves(forPieceAtRow: row, col: col).count
        return PieceSelectionInfo(row: row, col: col, piece: piece, moveCount: moves, canSelect: piecePlayer == currentPlayer)
    }
}
