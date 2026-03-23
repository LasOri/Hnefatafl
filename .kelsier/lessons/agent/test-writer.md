## Lessons: Test Writer (Spook)

### 1. [pattern] Run the test mentally before writing it
Before writing a test, check if the current implementation would already pass it.
Ray-casting inherently blocks at occupied squares — no separate "blocking" test needed.
Copenhagen piece count passed immediately because the data was correct.
King-on-corner passed immediately because the corner check already works for king.
**Rule: If you can reason that the test passes, skip it and find the NEXT gap.**

### 2. [pattern] Test for triangulation, not confirmation
A test that passes immediately doesn't drive design. Spook's job is to force a transformation.
Choose test cases that BREAK the current hardcoded/simplified implementation.
Example: After testing corner → test throne (forces if), then test regular (forces else).

### 3. [preference] Use Swift Testing framework (#expect) not XCTest
The project uses `import Testing` with `@Suite` and `@Test` macros, `#expect()` assertions.
Not `import XCTest` with `XCTAssertEqual`. Stick with the modern framework.

### 4. [correction] Count board state AFTER the move, not just setup
When testing "X survives" or "X is captured", count all pieces including the one that just moved.
The moved piece IS adjacent after the move. Don't count setup pieces only.
Bug found: "king on throne survives 3 attackers" actually had 4 attackers after the move landed.
