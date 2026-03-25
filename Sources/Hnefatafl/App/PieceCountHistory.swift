struct PieceCountSnapshot: Equatable {
    let attackers: Int
    let defenders: Int
    let moveNumber: Int
}

struct PieceCountHistory: Equatable {
    private(set) var snapshots: [PieceCountSnapshot] = []

    mutating func record(snapshot: PieceCountSnapshot) {
        snapshots.append(snapshot)
    }

    var attackerTrend: Int {
        guard snapshots.count >= 2 else { return 0 }
        return snapshots.last!.attackers - snapshots.first!.attackers
    }

    var defenderTrend: Int {
        guard snapshots.count >= 2 else { return 0 }
        return snapshots.last!.defenders - snapshots.first!.defenders
    }
}
