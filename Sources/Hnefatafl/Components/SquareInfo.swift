struct SquareInfoData: Equatable {
    let row: Int
    let col: Int
    let label: String
    let piece: Piece?
    let isSpecial: Bool
    let specialType: String?
}

enum SquareInfo {
    static func info(row: Int, col: Int, position: Position) -> SquareInfoData {
        let piece = position.pieceAt(row: row, col: col)
        let colLetter = String(UnicodeScalar(97 + col)!)
        let label = "\(colLetter)\(Position.boardSize - row)"
        let squareType = Position.squareType(row: row, col: col)
        let isSpecial = squareType != .regular
        let specialType: String?
        switch squareType {
        case .throne: specialType = "Throne"
        case .corner: specialType = "Corner"
        case .regular: specialType = nil
        }
        return SquareInfoData(row: row, col: col, label: label, piece: piece, isSpecial: isSpecial, specialType: specialType)
    }
}
