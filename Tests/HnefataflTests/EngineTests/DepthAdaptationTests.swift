import Testing
@testable import Hnefatafl

@Suite("Depth Adaptation Tests")
struct DepthAdaptationTests {

    @Test("start position gets near base depth")
    func startPositionBaseDepth() {
        let pos = Position.copenhagenStart()
        let depth = DepthAdaptation.recommendedDepth(position: pos, baseDepth: 4)
        #expect(depth >= 4)
        #expect(depth <= 7)
    }

    @Test("fewer pieces increases depth")
    func fewerPiecesIncreasesDepth() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .attacker
        cells[1] = .king
        cells[2] = .defender
        let sparsePos = Position(cells: cells)
        let sparseDepth = DepthAdaptation.recommendedDepth(position: sparsePos, baseDepth: 4)

        let fullPos = Position.copenhagenStart()
        let fullDepth = DepthAdaptation.recommendedDepth(position: fullPos, baseDepth: 4)

        #expect(sparseDepth >= fullDepth)
    }

    @Test("simple position detected for few pieces")
    func simplePositionDetected() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .king
        cells[1] = .attacker
        let pos = Position(cells: cells)
        #expect(DepthAdaptation.isSimplePosition(position: pos))
    }

    @Test("depth is bounded by base + 3")
    func depthBounded() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .king
        let pos = Position(cells: cells)
        let depth = DepthAdaptation.recommendedDepth(position: pos, baseDepth: 4)
        #expect(depth <= 7)
    }

    @Test("empty board is simple")
    func emptyBoardIsSimple() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        #expect(DepthAdaptation.isSimplePosition(position: pos))
    }
}
