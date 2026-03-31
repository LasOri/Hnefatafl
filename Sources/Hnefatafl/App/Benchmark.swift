import LINKER

struct BenchmarkResult<T> {
    let label: String
    let duration: Double
    let value: T
}

struct Benchmark {
    static func measure<T>(label: String, block: () -> T) -> BenchmarkResult<T> {
        let start = currentTimestamp()
        let value = block()
        let duration = currentTimestamp() - start
        return BenchmarkResult(label: label, duration: duration, value: value)
    }
}

struct BenchmarkSuite {
    private(set) var results: [BenchmarkResult<Int>] = []

    mutating func add(_ result: BenchmarkResult<Int>) {
        results.append(result)
    }

    var totalDuration: Double {
        results.reduce(0) { $0 + $1.duration }
    }

    var summary: String {
        results.map { "\($0.label): \($0.duration)s" }.joined(separator: "\n")
    }
}
