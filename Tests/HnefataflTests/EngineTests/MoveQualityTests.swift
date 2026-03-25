import Testing
@testable import Hnefatafl

@Suite("Move Quality Analyzer Tests")
struct MoveQualityAnalyzerTests {

    @Test("large drop is blunder")
    func largeDropBlunder() {
        let rating = MoveQualityAnalyzer.rate(evalBefore: 100, evalAfter: -200)
        #expect(rating == .blunder)
    }

    @Test("moderate drop is inaccuracy")
    func moderateDropInaccuracy() {
        let rating = MoveQualityAnalyzer.rate(evalBefore: 100, evalAfter: 30)
        #expect(rating == .inaccuracy)
    }

    @Test("small change is good")
    func smallChangeGood() {
        let rating = MoveQualityAnalyzer.rate(evalBefore: 100, evalAfter: 110)
        #expect(rating == .good)
    }

    @Test("notable improvement is excellent")
    func notableImprovementExcellent() {
        let rating = MoveQualityAnalyzer.rate(evalBefore: 0, evalAfter: 100)
        #expect(rating == .excellent)
    }

    @Test("huge improvement is brilliant")
    func hugeImprovementBrilliant() {
        let rating = MoveQualityAnalyzer.rate(evalBefore: 0, evalAfter: 300)
        #expect(rating == .brilliant)
    }

    @Test("all ratings are case iterable")
    func allCases() {
        #expect(MoveQualityRating.allCases.count == 5)
        #expect(MoveQualityRating.allCases.contains(.blunder))
        #expect(MoveQualityRating.allCases.contains(.brilliant))
    }

    @Test("identical eval is good")
    func identicalEvalGood() {
        let rating = MoveQualityAnalyzer.rate(evalBefore: 50, evalAfter: 50)
        #expect(rating == .good)
    }
}
