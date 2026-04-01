enum TacticalAggregator {
    static func compute(position: Position, player: Player) -> Int {
        let opponent: Player = player == .attacker ? .defender : .attacker

        // === Pressure signals ===
        let pressure = PressureScore.pressure(position: position, player: player)
        let linePressKing = LinePressure.totalPressureOnKing(position: position)
        let edgePress = EdgePressure.edgePressureTotal(position: position, player: player)
        let lateralPress = LateralPressure.totalLateral(position: position)
        let backRank = BackRankPressure.evaluate(position: position, player: player)
        let tension = BoardTension.tension(position: position)
        let siege = SiegeScore.siegeLevel(position: position)

        // Pressure favors attacker
        let pressureSignal: Int
        switch player {
        case .attacker:
            pressureSignal = (pressure + linePressKing / 2 + edgePress / 2 + lateralPress / 3 + backRank / 2 + siege / 2 + tension / 5) / 7
        case .defender:
            pressureSignal = -(pressure + linePressKing / 2 + edgePress / 2 + lateralPress / 3 + backRank / 2 + siege / 2 + tension / 5) / 7
        }

        // === Tempo signals ===
        let tempo1 = TempoEval.tempoAdvantage(position: position, player: player)
        let tempo2 = TempoBalance.tempoAdvantage(position: position, player: player)
        let tempoCount = TempoCounter.tempoCount(position: position, player: player)
        let initiative = InitiativeTracker.initiativeScore(position: position)
        let gameTempo = GameTempo.evaluate(position: position)

        let tempoAdj: Int
        switch player {
        case .attacker:
            tempoAdj = initiative
        case .defender:
            tempoAdj = -initiative
        }

        let gameTempoAdj: Int
        switch player {
        case .attacker:
            gameTempoAdj = gameTempo.attackerTempo - gameTempo.defenderTempo
        case .defender:
            gameTempoAdj = gameTempo.defenderTempo - gameTempo.attackerTempo
        }

        let tempoSignal = (tempo1 + tempo2 + tempoCount / 2 + tempoAdj + gameTempoAdj) / 5

        // === Tactical scores ===
        let tactical = TacticalScore.score(position: position, player: player)
        let counterAtk = CounterAttackEval.counterAttackScore(position: position, player: player)
        let intercept = InterceptionEval.interceptionScore(position: position)
        let retreat = RetreatEval.retreatScore(position: position, player: player)
        let overext = OverextensionEval.overextensionPenalty(position: position, player: player)
        let reinforce = ReinforcementEval.reinforcementPotential(position: position, player: player)
        let breakthrough = BreakthroughEval.evaluate(position: position)
        let doubleAtk = DoubleAttackEval.evaluate(position: position)

        // Intercept favors defender
        let interceptAdj: Int
        switch player {
        case .attacker:
            interceptAdj = -intercept
        case .defender:
            interceptAdj = intercept
        }

        // Breakthrough favors defender (king escaping)
        let breakAdj: Int
        switch player {
        case .attacker:
            breakAdj = -breakthrough
        case .defender:
            breakAdj = breakthrough
        }

        // Double attack favors attacker
        let doubleAtkAdj: Int
        switch player {
        case .attacker:
            doubleAtkAdj = doubleAtk
        case .defender:
            doubleAtkAdj = -doubleAtk
        }

        let tacticalSignal = (tactical + counterAtk / 2 + interceptAdj / 3 + retreat / 3
                             - overext + reinforce / 2 + breakAdj / 2 + doubleAtkAdj / 2) / 6

        // === Safety scores ===
        let strongPts = StrongPointEval.strongPointScore(position: position, player: player)
        let guardQual = GuardPostEval.guardQuality(position: position)
        let safeSqCount = SafeSquareEval.safeSquareCount(position: position)
        let passivity = PassivityDetector.passivityScore(position: position, player: player)

        // Guard quality and safe squares favor defender
        let safetyAdj: Int
        switch player {
        case .attacker:
            safetyAdj = strongPts / 2 - guardQual / 3 - safeSqCount / 5
        case .defender:
            safetyAdj = strongPts / 2 + guardQual / 3 + safeSqCount / 5
        }

        let safetySignal = (safetyAdj - passivity) / 3

        // === Progress/Phase scores ===
        let phaseScore = GamePhaseScore.evaluate(position: position, for: player)
        let atkAdv = AdvancementScore.attackerAdvancement(position: position)
        let defAdv = AdvancementScore.defenderAdvancement(position: position)
        let penetration = PenetrationDepth.maxPenetration(position: position)
        let transition = MiddlegameTransition.transitionScore(position: position)

        let advAdj: Int
        switch player {
        case .attacker:
            advAdj = atkAdv - defAdv + penetration / 2
        case .defender:
            advAdj = defAdv - atkAdv - penetration / 2
        }

        let progressSignal = (phaseScore.value / 3 + advAdj / 2 + transition / 3) / 3

        // === Detection adapters ===
        let forks = ForkDetector.forkCount(position: position, player: player)
        let forksOpp = ForkDetector.forkCount(position: position, player: opponent)
        let traps = TrapDetector.trapCount(position: position, player: player)
        let trapsOpp = TrapDetector.trapCount(position: position, player: opponent)
        let crossfire = CrossfireDetector.crossfireCount(position: position)
        let pinned = PinnedPieceDetector.pinnedCount(position: position, player: player)
        let pinnedOpp = PinnedPieceDetector.pinnedCount(position: position, player: opponent)
        let skewered = SkeweredPieceDetector.skewerCount(position: position, player: player)
        let skeweredOpp = SkeweredPieceDetector.skewerCount(position: position, player: opponent)

        let detectionSignal = (forks - forksOpp) * 3 - (traps - trapsOpp) * 2
                             - (pinned - pinnedOpp) * 2 - (skewered - skeweredOpp) * 2

        // Crossfire favors attacker
        let crossfireAdj: Int
        switch player {
        case .attacker:
            crossfireAdj = crossfire
        case .defender:
            crossfireAdj = -crossfire
        }

        // === Misc eval signals ===
        let volatility = VolatilityScore.volatility(position: position)
        let surround = SurroundScore.kingSurroundedness(position: position)
        let capSeq = CaptureSequenceEval.maxSequenceLength(position: position, player: player)
        let stability = PositionStability.stability(position: position)
        let emptyNearKing = EmptySquareEval.emptyNearKing(position: position)
        let staleRisk = StalemateDetector.stalemateRisk(position: position)
        let zugzwang = ZugzwangDetector.zugzwangScore(position: position, player: player)
        let nullMove = NullMoveHeuristic.nullMoveScore(position: position, player: player)
        let horizon = HorizonEffect.horizonRisk(position: position)
        let dynamic = DynamicEval.evaluate(position: position, player: player, moveCount: 0)
        let adaptive = AdaptiveEval.evaluate(position: position, player: player)
        let phaseEval = GamePhaseEvaluator.evaluateForPhase(position: position, player: player)

        // Surround favors attacker
        let surroundAdj: Int
        switch player {
        case .attacker:
            surroundAdj = surround
        case .defender:
            surroundAdj = -surround
        }

        // Empty near king favors defender (escape room)
        let emptyAdj: Int
        switch player {
        case .attacker:
            emptyAdj = -emptyNearKing
        case .defender:
            emptyAdj = emptyNearKing
        }

        let miscSignal = (surroundAdj / 3 + capSeq + stability / 3 + emptyAdj / 3
                         - staleRisk / 5 + zugzwang / 3 + nullMove / 5
                         - horizon / 5 + crossfireAdj + dynamic / 5 + adaptive / 5
                         + phaseEval / 5 + volatility / 5) / 9

        // === Additional orphaned pressure/safety modules ===
        let rowPress = RowPressure.evaluate(position: position, for: player)
        let colPress = ColumnPressure.evaluate(position: position, for: player)
        let safetyMargin = SafetyMargin.kingMargin(position: position)
        let progress = ProgressEval.gameProgress(position: position)
        let _ = MoveQualityAnalyzer.rate(evalBefore: 0, evalAfter: 0)
        let formBreakerCount = FormationBreaker.breakingMoveCount(position: position, player: player)
        let blockadeStr = BlockadeDetector.blockadeStrength(position: position)
        let encircleAdj = EncirclementDetector.adjacentAttackers(position: position)

        let safetyMarginAdj: Int
        switch player {
        case .attacker:
            safetyMarginAdj = -safetyMargin
        case .defender:
            safetyMarginAdj = safetyMargin
        }

        // Encirclement favors attacker
        let encircleSignal: Int
        switch player {
        case .attacker:
            encircleSignal = encircleAdj + blockadeStr / 2
        case .defender:
            encircleSignal = -encircleAdj - blockadeStr / 2
        }

        let extraTactical = (rowPress.count + colPress.count + safetyMarginAdj / 3
                            + formBreakerCount + encircleSignal / 2 + Int(progress * 2)) / 6

        // === Capture risk + piece safety ===
        let captureRiskEntries = CaptureRisk.assess(position: position, for: player)
        let captureRiskScore = captureRiskEntries.count
        let leastSafe = PieceSafetyScore.leastSafePiece(position: position, player: player)
        let safetyPenalty = leastSafe != nil ? PieceSafetyScore.safetyScore(row: leastSafe!.row, col: leastSafe!.col, position: position) : 0

        // === Combine all tactical signals ===
        return (pressureSignal + tempoSignal + tacticalSignal + safetySignal
               + progressSignal + detectionSignal / 3 + miscSignal + extraTactical / 3
               - captureRiskScore / 3 + safetyPenalty / 5) / 6
    }
}
