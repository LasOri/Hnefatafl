enum TacticalAggregator {
    static func compute(position: Position, player: Player) -> Int {
        let opponent = player.opponent

        let pressure = pressureSignal(position: position, player: player)
        let tempo = tempoSignal(position: position, player: player)
        let tactical = tacticalSignal(position: position, player: player)
        let safety = safetySignal(position: position, player: player)
        let progress = progressSignal(position: position, player: player)
        let detection = detectionSignal(position: position, player: player, opponent: opponent)
        let misc = miscSignal(position: position, player: player)
        let extra = extraTacticalSignal(position: position, player: player)
        let captureRisk = captureRiskSignal(position: position, player: player)

        return (pressure + tempo + tactical + safety
               + progress + detection / 3 + misc + extra / 3
               - captureRisk.score / 3 + captureRisk.penalty / 5) / 6
    }

    // MARK: - Pressure signals

    private static func pressureSignal(position: Position, player: Player) -> Int {
        let pressure = PressureScore.pressure(position: position, player: player)
        let linePressKing = LinePressure.totalPressureOnKing(position: position)
        let edgePress = EdgePressure.edgePressureTotal(position: position, player: player)
        let lateralPress = LateralPressure.totalLateral(position: position)
        let backRank = BackRankPressure.evaluate(position: position, player: player)
        let tension = BoardTension.tension(position: position)
        let siege = SiegeScore.siegeLevel(position: position)

        let raw = (pressure + linePressKing / 2 + edgePress / 2 + lateralPress / 3 + backRank / 2 + siege / 2 + tension / 5) / 7
        return PerspectiveAdjust.forAttackerPositive(raw, player: player)
    }

    // MARK: - Tempo signals

    private static func tempoSignal(position: Position, player: Player) -> Int {
        let tempo1 = TempoEval.tempoAdvantage(position: position, player: player)
        let tempo2 = TempoBalance.tempoAdvantage(position: position, player: player)
        let tempoCount = TempoCounter.tempoCount(position: position, player: player)
        let initiative = InitiativeTracker.initiativeScore(position: position)
        let gameTempo = GameTempo.evaluate(position: position)

        let tempoAdj = PerspectiveAdjust.forAttackerPositive(initiative, player: player)

        let gameTempoAdj: Int
        switch player {
        case .attacker:
            gameTempoAdj = gameTempo.attackerTempo - gameTempo.defenderTempo
        case .defender:
            gameTempoAdj = gameTempo.defenderTempo - gameTempo.attackerTempo
        }

        return (tempo1 + tempo2 + tempoCount / 2 + tempoAdj + gameTempoAdj) / 5
    }

    // MARK: - Tactical scores

    private static func tacticalSignal(position: Position, player: Player) -> Int {
        let tactical = TacticalScore.score(position: position, player: player)
        let counterAtk = CounterAttackEval.counterAttackScore(position: position, player: player)
        let intercept = InterceptionEval.interceptionScore(position: position)
        let retreat = RetreatEval.retreatScore(position: position, player: player)
        let overext = OverextensionEval.overextensionPenalty(position: position, player: player)
        let reinforce = ReinforcementEval.reinforcementPotential(position: position, player: player)
        let breakthrough = BreakthroughEval.evaluate(position: position)
        let doubleAtk = DoubleAttackEval.evaluate(position: position)

        let interceptAdj = PerspectiveAdjust.forDefenderPositive(intercept, player: player)
        let breakAdj = PerspectiveAdjust.forDefenderPositive(breakthrough, player: player)
        let doubleAtkAdj = PerspectiveAdjust.forAttackerPositive(doubleAtk, player: player)

        return (tactical + counterAtk / 2 + interceptAdj / 3 + retreat / 3
                             - overext + reinforce / 2 + breakAdj / 2 + doubleAtkAdj / 2) / 6
    }

    // MARK: - Safety scores

    private static func safetySignal(position: Position, player: Player) -> Int {
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

        return (safetyAdj - passivity) / 3
    }

    // MARK: - Progress/Phase scores

    private static func progressSignal(position: Position, player: Player) -> Int {
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

        return (phaseScore.value / 3 + advAdj / 2 + transition / 3) / 3
    }

    // MARK: - Detection adapters

    private static func detectionSignal(position: Position, player: Player, opponent: Player) -> Int {
        let forks = ForkDetector.forkCount(position: position, player: player)
        let forksOpp = ForkDetector.forkCount(position: position, player: opponent)
        let traps = TrapDetector.trapCount(position: position, player: player)
        let trapsOpp = TrapDetector.trapCount(position: position, player: opponent)
        let pinned = PinnedPieceDetector.pinnedCount(position: position, player: player)
        let pinnedOpp = PinnedPieceDetector.pinnedCount(position: position, player: opponent)
        let skewered = SkeweredPieceDetector.skewerCount(position: position, player: player)
        let skeweredOpp = SkeweredPieceDetector.skewerCount(position: position, player: opponent)

        return (forks - forksOpp) * 3 - (traps - trapsOpp) * 2
                             - (pinned - pinnedOpp) * 2 - (skewered - skeweredOpp) * 2
    }

    // MARK: - Misc eval signals

    private static func miscSignal(position: Position, player: Player) -> Int {
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
        let crossfire = CrossfireDetector.crossfireCount(position: position)

        let surroundAdj = PerspectiveAdjust.forAttackerPositive(surround, player: player)
        let emptyAdj = PerspectiveAdjust.forDefenderPositive(emptyNearKing, player: player)
        let crossfireAdj = PerspectiveAdjust.forAttackerPositive(crossfire, player: player)

        return (surroundAdj / 3 + capSeq + stability / 3 + emptyAdj / 3
                         - staleRisk / 5 + zugzwang / 3 + nullMove / 5
                         - horizon / 5 + crossfireAdj + dynamic / 5 + adaptive / 5
                         + phaseEval / 5 + volatility / 5) / 9
    }

    // MARK: - Extra tactical signals

    private static func extraTacticalSignal(position: Position, player: Player) -> Int {
        let rowPress = RowPressure.evaluate(position: position, for: player)
        let colPress = ColumnPressure.evaluate(position: position, for: player)
        let safetyMargin = SafetyMargin.kingMargin(position: position)
        let progress = ProgressEval.gameProgress(position: position)
        let _ = MoveQualityAnalyzer.rate(evalBefore: 0, evalAfter: 0)
        let formBreakerCount = FormationBreaker.breakingMoveCount(position: position, player: player)
        let blockadeStr = BlockadeDetector.blockadeStrength(position: position)
        let encircleAdj = EncirclementDetector.adjacentAttackers(position: position)

        let safetyMarginAdj = PerspectiveAdjust.forDefenderPositive(safetyMargin, player: player)

        // Encirclement favors attacker
        let encircleSignal: Int
        switch player {
        case .attacker:
            encircleSignal = encircleAdj + blockadeStr / 2
        case .defender:
            encircleSignal = -encircleAdj - blockadeStr / 2
        }

        return (rowPress.count + colPress.count + safetyMarginAdj / 3
                            + formBreakerCount + encircleSignal / 2 + Int(progress * 2)) / 6
    }

    // MARK: - Capture risk + piece safety

    private static func captureRiskSignal(position: Position, player: Player) -> (score: Int, penalty: Int) {
        let captureRiskEntries = CaptureRisk.assess(position: position, for: player)
        let captureRiskScore = captureRiskEntries.count
        let leastSafe = PieceSafetyScore.leastSafePiece(position: position, player: player)
        let safetyPenalty = leastSafe != nil ? PieceSafetyScore.safetyScore(row: leastSafe!.row, col: leastSafe!.col, position: position) : 0
        return (score: captureRiskScore, penalty: safetyPenalty)
    }
}
