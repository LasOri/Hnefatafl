## Lessons: TDD Pipeline

### 1. [pattern] Board games: build types bottom-up
Order: enums (Piece, SquareType, GameStatus) → value types (Position, Move) → pure functions (legalMoves, applyMove, gameStatus).
Each layer only depends on the one below.

### 2. [pattern] Hnefatafl domain: king is special everywhere
King can land on corners (others can't), king can't be custodial-captured (needs 4-side surround),
king+defender are the same side, hostile squares (corner, empty throne) help both sides capture.
Every rule function needs a `piece == .king` branch.

### 3. [antipattern] Don't test what's already guaranteed by implementation
If ray-casting stops at occupied squares by construction, don't write a separate "blocking" test.
If the test would pass without code changes, it's not driving design — find a better test.
