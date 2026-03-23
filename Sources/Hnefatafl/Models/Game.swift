struct Game {
    let position: Position
    let currentPlayer: Player
    let moveHistory: [Move]
    let positionHistory: [Position]

    init() {
        position = .copenhagenStart()
        currentPlayer = .attacker
        moveHistory = []
        positionHistory = [.copenhagenStart()]
    }

    init(position: Position, currentPlayer: Player, moveHistory: [Move], positionHistory: [Position] = []) {
        self.position = position
        self.currentPlayer = currentPlayer
        self.moveHistory = moveHistory
        self.positionHistory = positionHistory.isEmpty ? [position] : positionHistory
    }

    var status: GameStatus {
        let baseStatus = Position.gameStatus(position, currentPlayer: currentPlayer)
        guard baseStatus == .inProgress else { return baseStatus }
        let repetitionCount = positionHistory.filter { $0 == position }.count
        if repetitionCount >= 3 { return .draw }
        if moveHistory.count >= 200 { return .draw }
        return .inProgress
    }

    func makeMove(_ move: Move) -> Game {
        let newPosition = position.applyMove(move)
        let nextPlayer: Player = currentPlayer == .attacker ? .defender : .attacker
        return Game(
            position: newPosition,
            currentPlayer: nextPlayer,
            moveHistory: moveHistory + [move],
            positionHistory: positionHistory + [newPosition]
        )
    }
}
