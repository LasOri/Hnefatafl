struct LazyMoveGen: Equatable {
    let position: Position
    let player: Player
    private(set) var index: Int = 0
    private(set) var moves: [Move]

    init(position: Position, player: Player) {
        self.position = position
        self.player = player
        self.moves = position.allLegalMoves(for: player)
    }

    var hasNext: Bool { index < moves.count }
    var count: Int { moves.count }
    var generated: Int { index }

    mutating func next() -> Move? {
        guard index < moves.count else { return nil }
        let move = moves[index]
        index += 1
        return move
    }

    mutating func reset() {
        index = 0
    }
}
