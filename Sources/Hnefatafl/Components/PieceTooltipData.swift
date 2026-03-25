struct PieceTooltipData: Equatable {
    let piece: Piece
    let row: Int
    let col: Int
    let legalMoveCount: Int
    let isUnderThreat: Bool

    var displayInfo: String {
        let pieceName: String
        switch piece {
        case .attacker: pieceName = "Attacker"
        case .defender: pieceName = "Defender"
        case .king: pieceName = "King"
        }
        let threat = isUnderThreat ? " (threatened)" : ""
        return "\(pieceName) at (\(row),\(col)) — \(legalMoveCount) moves\(threat)"
    }
}
