import LINKER

struct TimerConfig: Equatable {
    let secondsPerSide: Int
    let label: String

    static let blitz = TimerConfig(secondsPerSide: 300, label: "5 min")
    static let standard = TimerConfig(secondsPerSide: 900, label: "15 min")
    static let none = TimerConfig(secondsPerSide: 0, label: "No Timer")
}

struct GameTimer: Equatable {
    let config: TimerConfig
    let attackerSeconds: Int
    let defenderSeconds: Int

    init(config: TimerConfig) {
        self.config = config
        self.attackerSeconds = config.secondsPerSide
        self.defenderSeconds = config.secondsPerSide
    }

    init(config: TimerConfig, attackerSeconds: Int, defenderSeconds: Int) {
        self.config = config
        self.attackerSeconds = attackerSeconds
        self.defenderSeconds = defenderSeconds
    }

    var isEnabled: Bool {
        config.secondsPerSide > 0
    }

    func tick(activePlayer: Player) -> GameTimer {
        switch activePlayer {
        case .attacker:
            return GameTimer(config: config, attackerSeconds: max(0, attackerSeconds - 1), defenderSeconds: defenderSeconds)
        case .defender:
            return GameTimer(config: config, attackerSeconds: attackerSeconds, defenderSeconds: max(0, defenderSeconds - 1))
        }
    }

    func isTimedOut(player: Player) -> Bool {
        guard isEnabled else { return false }
        switch player {
        case .attacker: return attackerSeconds <= 0
        case .defender: return defenderSeconds <= 0
        }
    }

    static func formatTime(seconds: Int) -> String {
        let mins = seconds / 60
        let secs = seconds % 60
        return "\(mins):\(zeroPad(secs, width: 2))"
    }
}
