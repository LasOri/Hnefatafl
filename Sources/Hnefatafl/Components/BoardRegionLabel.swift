enum RegionName: String, CaseIterable, Equatable {
    case center
    case northEdge
    case southEdge
    case eastEdge
    case westEdge
    case corner
}

struct BoardRegionLabel: Equatable {
    let region: RegionName
    let pieceCount: Int

    static func label(row: Int, col: Int) -> RegionName {
        let size = Position.boardSize
        let last = size - 1
        let isTop = row == 0
        let isBottom = row == last
        let isLeft = col == 0
        let isRight = col == last

        if (isTop || isBottom) && (isLeft || isRight) {
            return .corner
        }
        if isTop { return .northEdge }
        if isBottom { return .southEdge }
        if isLeft { return .westEdge }
        if isRight { return .eastEdge }
        return .center
    }
}
