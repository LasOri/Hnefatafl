struct BoardGridRenderer: Equatable {
    let cellSize: Int
    let borderWidth: Int
    let showCoordinates: Bool

    var totalSize: Int {
        cellSize * Position.boardSize + borderWidth * 2
    }
}
