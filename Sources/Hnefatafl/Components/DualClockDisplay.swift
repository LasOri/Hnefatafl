import LINKER

struct DualClockDisplay: Equatable {
    let attackerTime: Double
    let defenderTime: Double
    let activePlayer: Player

    var attackerFormatted: String {
        Self.formatTime(attackerTime)
    }

    var defenderFormatted: String {
        Self.formatTime(defenderTime)
    }

    var isLowTime: Bool {
        attackerTime < 30 || defenderTime < 30
    }

    private static func formatTime(_ seconds: Double) -> String {
        let mins = Int(seconds) / 60
        let secs = Int(seconds) % 60
        return "\(mins):\(zeroPad(secs, width: 2))"
    }
}
