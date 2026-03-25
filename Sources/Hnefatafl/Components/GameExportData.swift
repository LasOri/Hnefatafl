struct GameExportData: Equatable {
    let moves: [Move]
    let result: GameStatus
    let date: String

    var moveCount: Int {
        moves.count
    }
}
