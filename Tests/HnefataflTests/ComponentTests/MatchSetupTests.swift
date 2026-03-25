import Testing
@testable import Hnefatafl

@Suite("Match Setup Tests")
struct MatchSetupTests {

    @Test("has time limit when set")
    func hasTimeLimitTrue() {
        let setup = MatchSetup(playerSide: .attacker, aiEnabled: true, timeLimit: 300, variant: "copenhagen")
        #expect(setup.hasTimeLimit == true)
    }

    @Test("no time limit when nil")
    func hasTimeLimitFalse() {
        let setup = MatchSetup(playerSide: .defender, aiEnabled: false, timeLimit: nil, variant: "copenhagen")
        #expect(setup.hasTimeLimit == false)
    }

    @Test("player side stored correctly")
    func playerSide() {
        let setup = MatchSetup(playerSide: .defender, aiEnabled: true, timeLimit: nil, variant: "copenhagen")
        #expect(setup.playerSide == .defender)
    }

    @Test("ai enabled stored correctly")
    func aiEnabled() {
        let setup = MatchSetup(playerSide: .attacker, aiEnabled: true, timeLimit: nil, variant: "copenhagen")
        #expect(setup.aiEnabled == true)
    }

    @Test("equatable conformance")
    func equatable() {
        let a = MatchSetup(playerSide: .attacker, aiEnabled: true, timeLimit: 600, variant: "copenhagen")
        let b = MatchSetup(playerSide: .attacker, aiEnabled: true, timeLimit: 600, variant: "copenhagen")
        #expect(a == b)
    }

    @Test("different variants are not equal")
    func differentVariants() {
        let a = MatchSetup(playerSide: .attacker, aiEnabled: true, timeLimit: nil, variant: "copenhagen")
        let b = MatchSetup(playerSide: .attacker, aiEnabled: true, timeLimit: nil, variant: "tablut")
        #expect(a != b)
    }
}
