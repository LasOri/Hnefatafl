import Testing
@testable import Hnefatafl

@Suite("Toast Message Tests")
struct ToastMessageTests {

    @Test("info toast has correct type and duration")
    func infoToast() {
        let toast = ToastMessage.info("Game saved")
        #expect(toast.type == .info)
        #expect(toast.durationMs == 3000)
        #expect(toast.message == "Game saved")
    }

    @Test("warning toast has longer duration")
    func warningToast() {
        let toast = ToastMessage.warning("Low time")
        #expect(toast.type == .warning)
        #expect(toast.durationMs == 5000)
    }

    @Test("error toast has longest duration")
    func errorToast() {
        let toast = ToastMessage.error("Failed to save")
        #expect(toast.type == .error)
        #expect(toast.durationMs == 7000)
    }

    @Test("success toast has correct type")
    func successToast() {
        let toast = ToastMessage.success("Move accepted")
        #expect(toast.type == .success)
        #expect(toast.durationMs == 3000)
    }

    @Test("toast data equality")
    func toastEquality() {
        let a = ToastMessage.info("hello")
        let b = ToastMessage.info("hello")
        #expect(a == b)
    }
}
