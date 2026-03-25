struct PVLine: Equatable {
    let moves: [Move]

    init(moves: [Move] = []) {
        self.moves = moves
    }

    var bestMove: Move? { moves.first }
    var length: Int { moves.count }

    func prepend(_ move: Move) -> PVLine {
        PVLine(moves: [move] + moves)
    }

    func truncated(to maxLength: Int) -> PVLine {
        PVLine(moves: Array(moves.prefix(maxLength)))
    }
}
