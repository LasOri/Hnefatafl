struct GameReplay {
    let game: Game
    private(set) var currentMoveIndex: Int

    init(game: Game) {
        self.game = game
        self.currentMoveIndex = 0
    }

    var isAtStart: Bool { currentMoveIndex == 0 }
    var isAtEnd: Bool { currentMoveIndex == game.moveHistory.count }

    var currentPosition: Position {
        if currentMoveIndex < game.positionHistory.count {
            return game.positionHistory[currentMoveIndex]
        }
        return game.position
    }

    mutating func forward() {
        if currentMoveIndex < game.moveHistory.count {
            currentMoveIndex += 1
        }
    }

    mutating func backward() {
        if currentMoveIndex > 0 {
            currentMoveIndex -= 1
        }
    }
}
