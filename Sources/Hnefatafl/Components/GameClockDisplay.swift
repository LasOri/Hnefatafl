import LINKER

struct GameClockDisplay {
    static func format(seconds: Int) -> String {
        let hours = seconds / 3600
        let mins = (seconds % 3600) / 60
        let secs = seconds % 60

        if hours > 0 {
            return "\(hours):\(zeroPad(mins, width: 2)):\(zeroPad(secs, width: 2))"
        }
        return "\(mins):\(zeroPad(secs, width: 2))"
    }

    static func isLowTime(seconds: Int, threshold: Int = 60) -> Bool {
        seconds < threshold
    }

    static func progress(remaining: Int, total: Int) -> Double {
        guard total > 0 else { return 0 }
        let pct = Double(remaining) / Double(total) * 100.0
        return min(max(pct, 0), 100)
    }

    static func color(remaining: Int, total: Int) -> String {
        let pct = progress(remaining: remaining, total: total)
        if pct < 10 { return "#FF0000" }
        if pct < 25 { return "#FF8800" }
        return "#FFFFFF"
    }
}
