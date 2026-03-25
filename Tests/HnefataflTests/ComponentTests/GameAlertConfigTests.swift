import Testing
@testable import Hnefatafl

@Suite("GameAlertConfig Tests")
struct GameAlertConfigTests {

    @Test("isActive when severity > 0 and not dismissed")
    func isActiveWhenSevereAndNotDismissed() {
        let alert = GameAlertConfig(message: "Warning", severity: 2, isDismissed: false)
        #expect(alert.isActive == true)
    }

    @Test("not active when dismissed")
    func notActiveWhenDismissed() {
        let alert = GameAlertConfig(message: "Warning", severity: 2, isDismissed: true)
        #expect(alert.isActive == false)
    }

    @Test("not active when severity is zero")
    func notActiveWhenSeverityZero() {
        let alert = GameAlertConfig(message: "Info", severity: 0, isDismissed: false)
        #expect(alert.isActive == false)
    }

    @Test("lowTime factory creates correct alert")
    func lowTimeFactory() {
        let alert = GameAlertConfig.lowTime()
        #expect(alert.message == "Low time warning")
        #expect(alert.severity == 2)
        #expect(alert.isDismissed == false)
        #expect(alert.isActive == true)
    }

    @Test("kingInDanger factory creates correct alert")
    func kingInDangerFactory() {
        let alert = GameAlertConfig.kingInDanger()
        #expect(alert.message == "King is in danger")
        #expect(alert.severity == 3)
        #expect(alert.isDismissed == false)
        #expect(alert.isActive == true)
    }

    @Test("GameAlertConfig conforms to Equatable")
    func equatableConformance() {
        let a = GameAlertConfig(message: "Test", severity: 1, isDismissed: false)
        let b = GameAlertConfig(message: "Test", severity: 1, isDismissed: false)
        #expect(a == b)
    }

    @Test("different alerts are not equal")
    func differentAlertsNotEqual() {
        let a = GameAlertConfig.lowTime()
        let b = GameAlertConfig.kingInDanger()
        #expect(a != b)
    }
}
