import Testing
@testable import Hnefatafl

@Suite("GameBannerData Tests")
struct GameBannerDataTests {
    @Test("Check warning has correct text")
    func checkWarningText() {
        let banner = GameBannerData.checkWarning()
        #expect(banner.text == "King is in danger!")
    }

    @Test("Check warning is a warning")
    func checkWarningIsWarning() {
        let banner = GameBannerData.checkWarning()
        #expect(banner.isWarning == true)
    }

    @Test("Check warning is not dismissible")
    func checkWarningNotDismissible() {
        let banner = GameBannerData.checkWarning()
        #expect(banner.isDismissible == false)
    }

    @Test("Capture alert for one piece uses singular")
    func captureAlertSingular() {
        let banner = GameBannerData.captureAlert(count: 1)
        #expect(banner.text == "1 piece captured!")
    }

    @Test("Capture alert for multiple pieces uses plural")
    func captureAlertPlural() {
        let banner = GameBannerData.captureAlert(count: 3)
        #expect(banner.text == "3 pieces captured!")
    }

    @Test("Capture alert is dismissible and not a warning")
    func captureAlertProperties() {
        let banner = GameBannerData.captureAlert(count: 2)
        #expect(banner.isDismissible == true)
        #expect(banner.isWarning == false)
    }
}
