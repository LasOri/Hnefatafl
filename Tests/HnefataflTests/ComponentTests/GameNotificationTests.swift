import Testing
@testable import Hnefatafl

@Suite("Game Notification Tests")
struct GameNotificationTests {

    @Test("low priority is less than medium")
    func lowLessThanMedium() {
        #expect(NotificationPriority.low < NotificationPriority.medium)
    }

    @Test("medium priority is less than high")
    func mediumLessThanHigh() {
        #expect(NotificationPriority.medium < NotificationPriority.high)
    }

    @Test("low priority has rawValue 0")
    func lowRawValue() {
        #expect(NotificationPriority.low.rawValue == 0)
    }

    @Test("notification stores message")
    func storesMessage() {
        let n = GameNotification(message: "Your turn", priority: .medium)
        #expect(n.message == "Your turn")
    }

    @Test("notification stores priority")
    func storesPriority() {
        let n = GameNotification(message: "Check", priority: .high)
        #expect(n.priority == .high)
    }

    @Test("notifications are equatable")
    func equatable() {
        let a = GameNotification(message: "Test", priority: .low)
        let b = GameNotification(message: "Test", priority: .low)
        #expect(a == b)
    }

    @Test("different messages are not equal")
    func differentMessages() {
        let a = GameNotification(message: "A", priority: .low)
        let b = GameNotification(message: "B", priority: .low)
        #expect(a != b)
    }
}
