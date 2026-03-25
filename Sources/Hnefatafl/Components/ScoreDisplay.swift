struct ScoreDisplayData: Equatable {
    let attackerScore: Int
    let defenderScore: Int
    let advantage: String
}

enum ScoreDisplay {
    static func compute(position: Position) -> ScoreDisplayData {
        let atk = position.attackerCount * 100
        let def = position.defenderCount * 150
        let adv: String
        if atk > def {
            adv = "Attacker"
        } else if def > atk {
            adv = "Defender"
        } else {
            adv = "Even"
        }
        return ScoreDisplayData(attackerScore: atk, defenderScore: def, advantage: adv)
    }
}
