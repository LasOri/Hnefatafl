import Testing
@testable import Hnefatafl

@Suite("Trail Effect Tests")
struct TrailEffectTests {

    @Test("TrailEffect generates intermediate positions for horizontal move")
    func horizontalTrail() {
        let move = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 4)
        let trail = TrailEffect.intermediateSquares(for: move)
        #expect(trail.count == 3)
        #expect(trail[0].row == 0 && trail[0].col == 1)
        #expect(trail[1].row == 0 && trail[1].col == 2)
        #expect(trail[2].row == 0 && trail[2].col == 3)
    }

    @Test("TrailEffect generates intermediate positions for vertical move")
    func verticalTrail() {
        let move = Move(fromRow: 1, fromCol: 5, toRow: 5, toCol: 5)
        let trail = TrailEffect.intermediateSquares(for: move)
        #expect(trail.count == 3)
        #expect(trail[0].row == 2)
        #expect(trail[1].row == 3)
        #expect(trail[2].row == 4)
    }

    @Test("TrailEffect returns empty for adjacent move")
    func adjacentMove() {
        let move = Move(fromRow: 3, fromCol: 3, toRow: 3, toCol: 4)
        let trail = TrailEffect.intermediateSquares(for: move)
        #expect(trail.isEmpty)
    }

    @Test("TrailEffect opacity decays along trail")
    func opacityDecay() {
        let opacities = TrailEffect.opacities(count: 3)
        #expect(opacities.count == 3)
        #expect(opacities[0] > opacities[1])
        #expect(opacities[1] > opacities[2])
        #expect(opacities[2] > 0)
    }

    @Test("TrailEffect opacity for single element")
    func singleOpacity() {
        let opacities = TrailEffect.opacities(count: 1)
        #expect(opacities.count == 1)
        #expect(opacities[0] > 0)
    }

    @Test("TrailEffect opacity for zero count")
    func zeroCount() {
        let opacities = TrailEffect.opacities(count: 0)
        #expect(opacities.isEmpty)
    }

    @Test("TrailEffect handles reverse direction")
    func reverseDirection() {
        let move = Move(fromRow: 5, fromCol: 5, toRow: 5, toCol: 2)
        let trail = TrailEffect.intermediateSquares(for: move)
        #expect(trail.count == 2)
        #expect(trail[0].col == 4)
        #expect(trail[1].col == 3)
    }

    @Test("TrailEffect CSS class exists")
    func cssClassExists() {
        #expect(GameStyleSheet.css.contains("trail-fade"))
    }
}
