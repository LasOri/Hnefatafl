struct CaptureStreak {
    static func current(history: [Bool]) -> Int {
        var count = 0
        for capture in history.reversed() {
            if capture { count += 1 } else { break }
        }
        return count
    }

    static func longest(history: [Bool]) -> Int {
        var maxStreak = 0
        var current = 0
        for capture in history {
            if capture {
                current += 1
                maxStreak = max(maxStreak, current)
            } else {
                current = 0
            }
        }
        return maxStreak
    }

    static func totalCaptures(history: [Bool]) -> Int {
        history.filter { $0 }.count
    }
}
