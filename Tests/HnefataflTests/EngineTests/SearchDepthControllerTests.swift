import Testing
@testable import Hnefatafl

@Suite("SearchDepthController Tests")
struct SearchDepthControllerTests {

    @Test("same piece count gives base depth")
    func samePieceCount() {
        let config = SearchDepthController.configure(basePieces: 37, currentPieces: 37, baseDepth: 4)
        #expect(config.currentDepth == 4)
    }

    @Test("fewer pieces increases depth")
    func fewerPiecesDeeper() {
        let config = SearchDepthController.configure(basePieces: 37, currentPieces: 20, baseDepth: 4)
        #expect(config.currentDepth > 4)
    }

    @Test("minDepth equals baseDepth")
    func minDepthEqualsBase() {
        let config = SearchDepthController.configure(basePieces: 37, currentPieces: 37, baseDepth: 4)
        #expect(config.minDepth == 4)
    }

    @Test("maxDepth is baseDepth plus three")
    func maxDepthIsBasePlusThree() {
        let config = SearchDepthController.configure(basePieces: 37, currentPieces: 37, baseDepth: 4)
        #expect(config.maxDepth == 7)
    }

    @Test("currentDepth never exceeds maxDepth")
    func currentNeverExceedsMax() {
        let config = SearchDepthController.configure(basePieces: 37, currentPieces: 5, baseDepth: 4)
        #expect(config.currentDepth <= config.maxDepth)
    }
}
