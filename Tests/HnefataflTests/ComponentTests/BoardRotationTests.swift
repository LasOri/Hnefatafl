import Testing
@testable import Hnefatafl

@Suite("Board Rotation Tests")
struct BoardRotationTests {

    @Test("default rotation is none")
    func defaultNone() {
        let rotation = BoardRotation.none
        #expect(rotation.degrees == 0)
    }

    @Test("rotate 90 degrees")
    func rotate90() {
        #expect(BoardRotation.quarter.degrees == 90)
    }

    @Test("rotate 180 degrees")
    func rotate180() {
        #expect(BoardRotation.half.degrees == 180)
    }

    @Test("rotate 270 degrees")
    func rotate270() {
        #expect(BoardRotation.threeQuarter.degrees == 270)
    }

    @Test("next cycles through rotations")
    func nextCycles() {
        let first = BoardRotation.none
        let second = first.next
        let third = second.next
        let fourth = third.next
        let fifth = fourth.next
        #expect(fifth == first)
    }

    @Test("css transform")
    func cssTransform() {
        let rotation = BoardRotation.quarter
        #expect(rotation.cssTransform.contains("90"))
    }

    @Test("BoardRotation is Equatable")
    func equatable() {
        #expect(BoardRotation.none == BoardRotation.none)
        #expect(BoardRotation.none != BoardRotation.half)
    }

    @Test("transform coordinates for 180")
    func transformCoords() {
        let (r, c) = BoardRotation.half.transform(row: 0, col: 0, boardSize: 11)
        #expect(r == 10)
        #expect(c == 10)
    }
}
