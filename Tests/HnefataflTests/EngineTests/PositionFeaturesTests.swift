import Testing
@testable import Hnefatafl

@Suite("Position Features Tests")
struct PositionFeaturesTests {

    @Test("feature vector has 6 features")
    func featureVectorHas6Features() {
        let pos = Position.copenhagenStart()
        let fv = PositionFeatures.extract(position: pos)
        #expect(fv.count == 6)
    }

    @Test("start position features have correct counts")
    func startPositionFeatures() {
        let pos = Position.copenhagenStart()
        let fv = PositionFeatures.extract(position: pos)
        #expect(fv[0] == Double(pos.attackerCount))
        #expect(fv[1] == Double(pos.defenderCount))
    }

    @Test("ratios between 0 and 1")
    func ratiosBetween0And1() {
        let pos = Position.copenhagenStart()
        let fv = PositionFeatures.extract(position: pos)
        #expect(fv[2] >= 0 && fv[2] <= 1)
        #expect(fv[5] >= 0 && fv[5] <= 1)
    }

    @Test("empty position returns zero features")
    func emptyPositionFeatures() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let fv = PositionFeatures.extract(position: pos)
        #expect(fv[0] == 0)
        #expect(fv[1] == 0)
        #expect(fv[2] == 0)
        #expect(fv[5] == 0)
    }

    @Test("subscript access works")
    func subscriptAccessWorks() {
        let fv = FeatureVector(features: [1.0, 2.0, 3.0])
        #expect(fv[0] == 1.0)
        #expect(fv[1] == 2.0)
        #expect(fv[2] == 3.0)
    }

    @Test("feature count property matches array length")
    func featureCountCorrect() {
        let fv = FeatureVector(features: [10.0, 20.0, 30.0, 40.0])
        #expect(fv.count == 4)
    }
}
