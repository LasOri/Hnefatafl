enum NotificationPriority: Int, Comparable, Equatable {
    case low = 0
    case medium = 1
    case high = 2

    static func < (lhs: NotificationPriority, rhs: NotificationPriority) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

struct GameNotification: Equatable {
    let message: String
    let priority: NotificationPriority
}
