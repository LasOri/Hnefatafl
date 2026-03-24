import LINKER

struct ClockDisplay {
    static let lowTimeThreshold = 30

    static func render(timer: GameTimer, activePlayer: Player) -> [AnyNode] {
        guard timer.isEnabled else { return [] }

        let attackerTime = GameTimer.formatTime(seconds: timer.attackerSeconds)
        let defenderTime = GameTimer.formatTime(seconds: timer.defenderSeconds)

        let attackerClasses = clockClasses(
            isActive: activePlayer == .attacker,
            isLow: timer.attackerSeconds <= lowTimeThreshold
        )
        let defenderClasses = clockClasses(
            isActive: activePlayer == .defender,
            isLow: timer.defenderSeconds <= lowTimeThreshold
        )

        let attackerSpan = Element<AnyHTMLContext>(
            tag: "span",
            attributes: [Attribute(name: "class", value: attackerClasses)],
            children: [AnyNode(Text("Attacker " + attackerTime))]
        )

        let defenderSpan = Element<AnyHTMLContext>(
            tag: "span",
            attributes: [Attribute(name: "class", value: defenderClasses)],
            children: [AnyNode(Text("Defender " + defenderTime))]
        )

        let container = Element<AnyHTMLContext>(
            tag: "div",
            attributes: [Attribute(name: "class", value: "clock-display")],
            children: [AnyNode(attackerSpan), AnyNode(defenderSpan)]
        )

        return [AnyNode(container)]
    }

    private static func clockClasses(isActive: Bool, isLow: Bool) -> String {
        var classes = "clock"
        if isActive { classes += " clock-active" }
        if isLow { classes += " clock-low" }
        return classes
    }
}
