struct MoveSpeedData: Equatable {
    let distance: Int
    let duration: Double
    let speedClass: SpeedClass
}

enum SpeedClass: Equatable {
    case fast
    case normal
    case slow
}

enum MoveSpeed {
    static func calculate(move: Move) -> MoveSpeedData {
        let dist = abs(move.toRow - move.fromRow) + abs(move.toCol - move.fromCol)
        let duration = 0.1 + Double(dist) * 0.05
        let speedClass: SpeedClass
        if dist <= 2 { speedClass = .fast }
        else if dist <= 5 { speedClass = .normal }
        else { speedClass = .slow }
        return MoveSpeedData(distance: dist, duration: duration, speedClass: speedClass)
    }
}
