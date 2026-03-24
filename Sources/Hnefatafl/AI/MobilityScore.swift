struct Mobility: Equatable {
    let attackerMoves: Int
    let defenderMoves: Int

    var ratio: Int { attackerMoves - defenderMoves }
    var totalMoves: Int { attackerMoves + defenderMoves }

    var advantage: Player? {
        if attackerMoves > defenderMoves { return .attacker }
        if defenderMoves > attackerMoves { return .defender }
        return nil
    }
}

struct MobilityScore {
    static func compute(position: Position) -> Mobility {
        let attackerMoves = position.allLegalMoves(for: .attacker).count
        let defenderMoves = position.allLegalMoves(for: .defender).count
        return Mobility(attackerMoves: attackerMoves, defenderMoves: defenderMoves)
    }
}
