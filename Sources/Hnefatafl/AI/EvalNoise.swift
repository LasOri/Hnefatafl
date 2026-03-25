struct EvalNoise: Equatable {
    let seed: UInt64
    let amplitude: Int

    func noise(for move: Move) -> Int {
        var h = seed
        h ^= UInt64(move.fromRow &* 17 &+ move.fromCol &* 31)
        h ^= UInt64(move.toRow &* 53 &+ move.toCol &* 97)
        h = h &* 6364136223846793005 &+ 1442695040888963407
        let raw = Int(h % UInt64(amplitude * 2 + 1))
        return raw - amplitude
    }

    static func withAmplitude(_ amp: Int, seed: UInt64 = 42) -> EvalNoise {
        EvalNoise(seed: seed, amplitude: max(0, amp))
    }
}
