import Testing
@testable import Hnefatafl

@Suite("Move Annotation Tests")
struct MoveAnnotationTests {

    let sampleMove = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 1)
    let pos = Position(cells: Array(repeating: nil, count: 121))

    @Test("normal annotation for small diff")
    func normalForSmallDiff() {
        let annotated = MoveAnnotation.annotate(move: sampleMove, position: pos, player: .attacker, evalBefore: 100, evalAfter: 110)
        #expect(annotated.quality == .normal)
        #expect(annotated.annotation == "")
    }

    @Test("brilliant for large positive diff")
    func brilliantForLargePositive() {
        let annotated = MoveAnnotation.annotate(move: sampleMove, position: pos, player: .attacker, evalBefore: 0, evalAfter: 300)
        #expect(annotated.quality == .brilliant)
        #expect(annotated.annotation == "!!")
    }

    @Test("blunder for large negative diff")
    func blunderForLargeNegative() {
        let annotated = MoveAnnotation.annotate(move: sampleMove, position: pos, player: .attacker, evalBefore: 300, evalAfter: 0)
        #expect(annotated.quality == .blunder)
        #expect(annotated.annotation == "??")
    }

    @Test("all qualities have raw values")
    func allQualitiesHaveRawValues() {
        let qualities: [MoveQuality] = [.brilliant, .good, .interesting, .dubious, .mistake, .blunder, .normal]
        for q in qualities {
            #expect(q.rawValue is String)
        }
        #expect(qualities.count == 7)
    }

    @Test("annotated move has correct move")
    func annotatedMoveHasCorrectMove() {
        let annotated = MoveAnnotation.annotate(move: sampleMove, position: pos, player: .attacker, evalBefore: 0, evalAfter: 0)
        #expect(annotated.move == sampleMove)
    }

    @Test("quality enum covers all thresholds")
    func qualityEnumCases() {
        let diffs = [250, 150, 75, 0, -75, -150, -250]
        let expected: [MoveQuality] = [.brilliant, .good, .interesting, .normal, .dubious, .mistake, .blunder]
        for (diff, exp) in zip(diffs, expected) {
            let annotated = MoveAnnotation.annotate(move: sampleMove, position: pos, player: .attacker, evalBefore: 0, evalAfter: diff)
            #expect(annotated.quality == exp)
        }
    }
}
