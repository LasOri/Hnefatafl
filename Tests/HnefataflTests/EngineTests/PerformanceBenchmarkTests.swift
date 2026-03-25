import Testing
@testable import Hnefatafl

@Suite("Performance Benchmark Tests")
struct PerformanceBenchmarkTests {

    @Test("benchmark records duration")
    func recordsDuration() {
        let result = Benchmark.measure(label: "test") { 1 + 1 }
        #expect(result.duration >= 0)
        #expect(result.label == "test")
    }

    @Test("benchmark returns value")
    func returnsValue() {
        let result = Benchmark.measure(label: "add") { 42 }
        #expect(result.value == 42)
    }

    @Test("move generation benchmark")
    func moveGenBenchmark() {
        let position = Position.copenhagenStart()
        let result = Benchmark.measure(label: "moveGen") {
            position.allLegalMoves(for: .attacker).count
        }
        #expect(result.value > 0)
        #expect(result.duration >= 0)
    }

    @Test("evaluation benchmark")
    func evalBenchmark() {
        let game = Game()
        let result = Benchmark.measure(label: "eval") {
            EvaluationAI.evaluate(position: game.position, for: .attacker)
        }
        #expect(result.duration >= 0)
    }

    @Test("BenchmarkResult has label and duration")
    func resultProperties() {
        let result = BenchmarkResult(label: "x", duration: 1.5, value: 0)
        #expect(result.label == "x")
        #expect(result.duration == 1.5)
    }

    @Test("BenchmarkSuite collects multiple results")
    func suiteCollects() {
        var suite = BenchmarkSuite()
        suite.add(BenchmarkResult(label: "a", duration: 1.0, value: 0))
        suite.add(BenchmarkResult(label: "b", duration: 2.0, value: 0))
        #expect(suite.results.count == 2)
    }

    @Test("BenchmarkSuite reports total duration")
    func totalDuration() {
        var suite = BenchmarkSuite()
        suite.add(BenchmarkResult(label: "a", duration: 1.0, value: 0))
        suite.add(BenchmarkResult(label: "b", duration: 2.0, value: 0))
        #expect(suite.totalDuration == 3.0)
    }

    @Test("BenchmarkSuite summary is not empty")
    func summaryNotEmpty() {
        var suite = BenchmarkSuite()
        suite.add(BenchmarkResult(label: "test", duration: 0.5, value: 0))
        #expect(!suite.summary.isEmpty)
    }
}
