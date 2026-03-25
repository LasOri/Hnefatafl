import Testing
@testable import Hnefatafl

@Suite("Feedback Message Tests")
struct FeedbackMessageTests {

    @Test("info message creation")
    func infoMessage() {
        let msg = FeedbackMessage(text: "Your turn", type: .info, autoDismiss: true)
        #expect(msg.text == "Your turn")
        #expect(msg.type == .info)
        #expect(msg.autoDismiss == true)
    }

    @Test("error message creation")
    func errorMessage() {
        let msg = FeedbackMessage(text: "Invalid move", type: .error, autoDismiss: false)
        #expect(msg.type == .error)
        #expect(msg.autoDismiss == false)
    }

    @Test("all feedback types have raw values")
    func feedbackTypeRawValues() {
        #expect(FeedbackType.info.rawValue == "info")
        #expect(FeedbackType.success.rawValue == "success")
        #expect(FeedbackType.warning.rawValue == "warning")
        #expect(FeedbackType.error.rawValue == "error")
    }

    @Test("messages are equatable")
    func equatable() {
        let a = FeedbackMessage(text: "Hello", type: .info, autoDismiss: true)
        let b = FeedbackMessage(text: "Hello", type: .info, autoDismiss: true)
        #expect(a == b)
    }

    @Test("different text means different messages")
    func differentText() {
        let a = FeedbackMessage(text: "Hello", type: .info, autoDismiss: true)
        let b = FeedbackMessage(text: "World", type: .info, autoDismiss: true)
        #expect(a != b)
    }

    @Test("different type means different messages")
    func differentType() {
        let a = FeedbackMessage(text: "Hello", type: .info, autoDismiss: true)
        let b = FeedbackMessage(text: "Hello", type: .warning, autoDismiss: true)
        #expect(a != b)
    }

    @Test("success and warning types exist")
    func successAndWarning() {
        let s = FeedbackMessage(text: "Captured!", type: .success, autoDismiss: true)
        let w = FeedbackMessage(text: "King exposed", type: .warning, autoDismiss: false)
        #expect(s.type == .success)
        #expect(w.type == .warning)
    }
}
