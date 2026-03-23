## Lessons: Dumb Implementer (Hammond)

### 1. [pattern] Obvious Implementation is OK for pure data
When the implementation is pure constant data (no logic), use Obvious Implementation instead of Fake It.
Copenhagen starting position is 37 pieces at fixed coordinates — no point hardcoding one piece at a time.
**Rule: Fake It for logic, Obvious for data.**

### 2. [correction] King is on defender's side for captures
When checking capture sides, king + defender = same team, attacker = other team.
Use `isAttacker = (piece == .attacker)` not a three-way check.
The king cannot be captured by custodial sandwich (needs 4-side surround) — always `guard neighbor != .king`.

### 3. [pattern] Hostile squares replace the "beyond" piece check
Corners and empty throne act as capture partners for BOTH sides.
Check hostile squares separately from the friendly-piece-beyond check.
Pattern: `if isHostileSquare { capture } else if friendlyBeyond { capture }`

### 4. [preference] Keep Position immutable — return new Position from applyMove
All mutations go through `var newCells = cells`, then `return Position(cells: newCells)`.
Never mutate `self`. This is the core invariant of the pure functional engine.

### 5. [pattern] King capture needs a separate function
Regular custodial capture and king capture have completely different rules.
Regular capture: sandwich between 2 friendly pieces (or hostile square).
King capture: depends on position (throne: 4 sides, adjacent: 3+throne, elsewhere: custodial).
Implement as `checkKingCapture()` called after the regular capture loop.
