import Testing
@testable import Hnefatafl

@Suite("Eval Noise Tests")
struct EvalNoiseTests {

    @Test("zero amplitude returns zero")
    func zeroAmplitudeReturnsZero() {
        let noise = EvalNoise.withAmplitude(0)
        let move = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 1)
        #expect(noise.noise(for: move) == 0)
    }

    @Test("noise within amplitude range")
    func noiseWithinRange() {
        let noise = EvalNoise.withAmplitude(10, seed: 123)
        let moves = (0..<11).map { Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: $0) }
        for m in moves {
            let n = noise.noise(for: m)
            #expect(n >= -10)
            #expect(n <= 10)
        }
    }

    @Test("same move produces same noise (deterministic)")
    func deterministic() {
        let noise = EvalNoise.withAmplitude(50, seed: 99)
        let move = Move(fromRow: 3, fromCol: 4, toRow: 7, toCol: 4)
        let n1 = noise.noise(for: move)
        let n2 = noise.noise(for: move)
        #expect(n1 == n2)
    }

    @Test("different moves produce different noise usually")
    func differentMovesDifferentNoise() {
        let noise = EvalNoise.withAmplitude(100, seed: 42)
        let m1 = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 1)
        let m2 = Move(fromRow: 5, fromCol: 5, toRow: 5, toCol: 6)
        let m3 = Move(fromRow: 10, fromCol: 10, toRow: 10, toCol: 9)
        let noises = Set([noise.noise(for: m1), noise.noise(for: m2), noise.noise(for: m3)])
        #expect(noises.count >= 2)
    }

    @Test("factory method sets amplitude")
    func factoryMethodSetsAmplitude() {
        let noise = EvalNoise.withAmplitude(25)
        #expect(noise.amplitude == 25)
        let negNoise = EvalNoise.withAmplitude(-5)
        #expect(negNoise.amplitude == 0)
    }
}
