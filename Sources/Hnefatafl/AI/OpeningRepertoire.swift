enum OpeningRepertoire {
    private static let attackerOpenings: [(moveNumber: Int, move: Move)] = [
        (1, Move(fromRow: 0, fromCol: 5, toRow: 2, toCol: 5)),
        (1, Move(fromRow: 5, fromCol: 0, toRow: 5, toCol: 2)),
        (3, Move(fromRow: 0, fromCol: 3, toRow: 3, toCol: 3)),
    ]

    private static let defenderOpenings: [(moveNumber: Int, move: Move)] = [
        (2, Move(fromRow: 4, fromCol: 5, toRow: 4, toCol: 3)),
        (2, Move(fromRow: 5, fromCol: 4, toRow: 3, toCol: 4)),
        (4, Move(fromRow: 5, fromCol: 6, toRow: 5, toCol: 8)),
    ]

    static func suggestedMove(for player: Player, moveNumber: Int) -> Move? {
        let book = player == .attacker ? attackerOpenings : defenderOpenings
        return book.first { $0.moveNumber == moveNumber }?.move
    }

    static func isBookMove(move: Move, player: Player) -> Bool {
        let book = player == .attacker ? attackerOpenings : defenderOpenings
        return book.contains { $0.move == move }
    }
}
