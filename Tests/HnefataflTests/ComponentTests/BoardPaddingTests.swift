import Testing
@testable import Hnefatafl

@Suite("Board Padding Tests")
struct BoardPaddingTests {

    @Test("standard preset has equal sides")
    func standardPreset() {
        let p = BoardPadding.standard
        #expect(p.top == 8)
        #expect(p.right == 8)
        #expect(p.bottom == 8)
        #expect(p.left == 8)
    }

    @Test("none preset is all zeros")
    func nonePreset() {
        let p = BoardPadding.none
        #expect(p.top == 0)
        #expect(p.horizontal == 0)
        #expect(p.vertical == 0)
    }

    @Test("horizontal is left plus right")
    func horizontalComputed() {
        let p = BoardPadding(top: 1, right: 5, bottom: 1, left: 3)
        #expect(p.horizontal == 8)
    }

    @Test("vertical is top plus bottom")
    func verticalComputed() {
        let p = BoardPadding(top: 4, right: 1, bottom: 6, left: 1)
        #expect(p.vertical == 10)
    }

    @Test("equatable conformance")
    func equatable() {
        let a = BoardPadding(top: 1, right: 2, bottom: 3, left: 4)
        let b = BoardPadding(top: 1, right: 2, bottom: 3, left: 4)
        #expect(a == b)
    }

    @Test("different values are not equal")
    func notEqual() {
        let a = BoardPadding.standard
        let b = BoardPadding.none
        #expect(a != b)
    }
}
