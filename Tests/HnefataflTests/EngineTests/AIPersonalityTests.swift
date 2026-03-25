import Testing
@testable import Hnefatafl

@Suite("AI Personality Tests")
struct AIPersonalityTests {

    @Test("aggressive personality favors material")
    func aggressiveMaterial() {
        let personality = AIPersonality.aggressive
        #expect(personality.weights.material > EvalWeights().material)
    }

    @Test("defensive personality favors king safety")
    func defensiveKingSafety() {
        let personality = AIPersonality.defensive
        #expect(personality.weights.kingSafety > EvalWeights().kingSafety)
    }

    @Test("balanced personality uses defaults")
    func balancedDefaults() {
        let personality = AIPersonality.balanced
        #expect(personality.weights == EvalWeights())
    }

    @Test("personality has name")
    func hasName() {
        #expect(AIPersonality.aggressive.name == "Aggressive")
        #expect(AIPersonality.defensive.name == "Defensive")
        #expect(AIPersonality.balanced.name == "Balanced")
    }

    @Test("personality has description")
    func hasDescription() {
        for personality in AIPersonality.allCases {
            #expect(!personality.description.isEmpty)
        }
    }

    @Test("allCases has three personalities")
    func threeCases() {
        #expect(AIPersonality.allCases.count == 3)
    }

    @Test("personality is Equatable")
    func equatable() {
        #expect(AIPersonality.aggressive == AIPersonality.aggressive)
        #expect(AIPersonality.aggressive != AIPersonality.defensive)
    }

    @Test("next cycles through personalities")
    func nextCycles() {
        let first = AIPersonality.balanced
        let second = first.next
        let third = second.next
        let fourth = third.next
        #expect(fourth == first)
    }
}
