struct CellSize: Equatable {
    let width: Int
    let height: Int

    var isSquare: Bool { width == height }

    static func responsive(containerWidth: Int) -> CellSize {
        let side = containerWidth / Position.boardSize
        return CellSize(width: side, height: side)
    }
}
