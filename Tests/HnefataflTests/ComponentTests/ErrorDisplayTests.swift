import Testing
@testable import Hnefatafl

@Suite("Error Display Tests")
struct ErrorDisplayTests {

    @Test("validation error is recoverable")
    func validationIsRecoverable() {
        let info = ErrorDisplay.fromValidation("Invalid move")
        #expect(info.isRecoverable == true)
        #expect(info.code == "VALIDATION")
    }

    @Test("system error is not recoverable")
    func systemNotRecoverable() {
        let info = ErrorDisplay.fromSystem("Fatal crash")
        #expect(info.isRecoverable == false)
        #expect(info.code == "SYSTEM")
    }

    @Test("network error is recoverable")
    func networkIsRecoverable() {
        let info = ErrorDisplay.fromNetwork("Connection lost")
        #expect(info.isRecoverable == true)
        #expect(info.code == "NETWORK")
    }

    @Test("error preserves message")
    func preservesMessage() {
        let info = ErrorDisplay.fromValidation("Piece cannot move there")
        #expect(info.message == "Piece cannot move there")
    }

    @Test("error info equality")
    func errorInfoEquality() {
        let a = ErrorDisplay.fromSystem("err")
        let b = ErrorDisplay.fromSystem("err")
        #expect(a == b)
    }
}
