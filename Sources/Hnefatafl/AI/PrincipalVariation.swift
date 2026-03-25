struct PrincipalVariation: Equatable {
    private(set) var moves: [Move] = []

    mutating func update(move: Move, continuation: PrincipalVariation) {
        moves = [move] + continuation.moves
    }

    var length: Int { moves.count }
    var bestMove: Move? { moves.first }
    var isEmpty: Bool { moves.isEmpty }

    mutating func clear() {
        moves.removeAll()
    }
}
