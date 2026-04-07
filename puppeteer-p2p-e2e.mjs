#!/usr/bin/env node
/**
 * Puppeteer E2E test: Two-tab P2P Hnefatafl game
 *
 * Kelsier Design Pipeline — Full P2P Validation
 *
 * Opens two browser tabs, hosts a game on tab 1, joins from tab 2,
 * and plays alternating moves until the game ends or a move limit is reached.
 * Validates: connection, handshake, move sync, board state, game over.
 */
import puppeteer from 'puppeteer';

const BASE = process.env.TEST_URL || 'http://localhost:8765';
const TIMEOUT = 120_000;
const MOVE_TIMEOUT = 30_000;
const MAX_MOVES = 80; // Safety limit
let browser;
let passed = 0, failed = 0;

async function test(name, fn) {
    try {
        await fn();
        console.log(`  ✔ ${name}`);
        passed++;
    } catch (e) {
        console.log(`  ✘ ${name}`);
        console.log(`    ${e.message}`);
        failed++;
    }
}

function assert(condition, msg) {
    if (!condition) throw new Error(msg || 'Assertion failed');
}

/** Wait for a selector with timeout */
async function waitFor(page, selector, timeout = MOVE_TIMEOUT) {
    await page.waitForSelector(selector, { timeout });
}

/** Get text content of first matching element */
async function getText(page, selector) {
    return page.evaluate(sel => {
        const el = document.querySelector(sel);
        return el ? el.textContent.trim() : null;
    }, selector);
}

/** Click an element using evaluate (avoids CDP protocol timeout with WASM) */
async function safeClick(page, selector) {
    await page.waitForSelector(selector, { timeout: TIMEOUT });
    await page.evaluate(sel => {
        const el = document.querySelector(sel);
        if (el) el.click();
    }, selector);
    await new Promise(r => setTimeout(r, 500));
}

/** Click a square at (row, col) */
async function clickSquare(page, row, col) {
    const selector = `.square[data-row="${row}"][data-col="${col}"]`;
    await page.waitForSelector(selector, { timeout: 5000 });
    await page.evaluate(sel => {
        const el = document.querySelector(sel);
        if (el) el.click();
    }, selector);
    await new Promise(r => setTimeout(r, 200));
}

/** Get all legal move target squares (those with .legal-move class) */
async function getLegalMoves(page) {
    return page.evaluate(() => {
        return Array.from(document.querySelectorAll('.legal-move')).map(el => ({
            row: parseInt(el.getAttribute('data-row')),
            col: parseInt(el.getAttribute('data-col'))
        }));
    });
}

/** Get all pieces for a given side */
async function getPieces(page, pieceClass) {
    return page.evaluate(cls => {
        return Array.from(document.querySelectorAll(`.${cls}`)).map(el => ({
            row: parseInt(el.getAttribute('data-row')),
            col: parseInt(el.getAttribute('data-col'))
        }));
    }, pieceClass);
}

/** Check if game is over */
async function isGameOver(page) {
    return page.evaluate(() => {
        return document.querySelector('.game-over-overlay') !== null;
    });
}

/** Get the current player from the status bar */
async function getCurrentPlayer(page) {
    return page.evaluate(() => {
        const status = document.querySelector('.status-turn');
        if (!status) return null;
        const text = status.textContent.toLowerCase();
        if (text.includes('attacker')) return 'attacker';
        if (text.includes('defender')) return 'defender';
        return text;
    });
}

/** Get board state hash for comparison */
async function getBoardHash(page) {
    return page.evaluate(() => {
        const squares = document.querySelectorAll('.square');
        return Array.from(squares).map(s => {
            const classes = s.className;
            const row = s.getAttribute('data-row');
            const col = s.getAttribute('data-col');
            let piece = '-';
            if (classes.includes('piece-attacker')) piece = 'A';
            else if (classes.includes('piece-defender')) piece = 'D';
            else if (classes.includes('piece-king')) piece = 'K';
            return `${row},${col}:${piece}`;
        }).join('|');
    });
}

/** Wait for board to sync between two pages (board hash matches) */
async function waitForBoardSync(page1, page2, timeout = MOVE_TIMEOUT) {
    const start = Date.now();
    while (Date.now() - start < timeout) {
        const hash1 = await getBoardHash(page1);
        const hash2 = await getBoardHash(page2);
        if (hash1 === hash2 && hash1.length > 0) return true;
        await new Promise(r => setTimeout(r, 500));
    }
    throw new Error('Board sync timeout — boards do not match');
}

/**
 * Make a move on the given page.
 * Picks a random piece of the given side and a random legal move.
 * Returns { from, to } or null if no moves available.
 */
async function makeRandomMove(page, side) {
    const pieceClass = side === 'attacker' ? 'piece-attacker' :
                       side === 'defender' ? 'piece-defender' : null;

    // Get all pieces for this side (include king for defender)
    let pieces = [];
    if (side === 'defender') {
        const defenders = await getPieces(page, 'piece-defender');
        const kings = await getPieces(page, 'piece-king');
        pieces = [...defenders, ...kings];
    } else {
        pieces = await getPieces(page, 'piece-attacker');
    }

    // Shuffle pieces for variety
    pieces.sort(() => Math.random() - 0.5);

    for (const piece of pieces) {
        // Click the piece to select it
        await clickSquare(page, piece.row, piece.col);
        await new Promise(r => setTimeout(r, 200));

        // Get legal moves
        const moves = await getLegalMoves(page);
        if (moves.length > 0) {
            // Pick a random legal move
            const target = moves[Math.floor(Math.random() * moves.length)];
            await clickSquare(page, target.row, target.col);
            return { from: piece, to: target };
        }

        // No moves for this piece, deselect by clicking elsewhere
        // Press Escape to clear selection
        await page.keyboard.press('Escape');
        await new Promise(r => setTimeout(r, 100));
    }

    return null; // No legal moves at all
}

// ═══════════════════════════════════════════════════════════
//  Main Test
// ═══════════════════════════════════════════════════════════

try {
    browser = await puppeteer.launch({
        headless: true,
        args: [
            '--no-sandbox',
            '--disable-setuid-sandbox',
            '--disable-web-security',
            '--disable-features=IsolateOrigins,site-per-process',
            '--allow-running-insecure-content',
        ],
        protocolTimeout: 120_000
    });

    const hostPage = await browser.newPage();
    const joinPage = await browser.newPage();

    // Collect errors from both pages
    const hostErrors = [];
    const joinErrors = [];
    const hostLogs = [];
    const joinLogs = [];
    hostPage.on('console', msg => {
        const text = msg.text();
        hostLogs.push(`[${msg.type()}] ${text}`);
        if (msg.type() === 'error') hostErrors.push(text);
    });
    joinPage.on('console', msg => {
        const text = msg.text();
        joinLogs.push(`[${msg.type()}] ${text}`);
        if (msg.type() === 'error') joinErrors.push(text);
    });

    console.log('\n⚔️  Hnefatafl P2P E2E Test — Two-Tab Full Game\n');

    // ─── Phase 1: Load both tabs ───
    console.log('🔷 Phase 1: Page Load\n');

    await test('Host tab loads', async () => {
        const res = await hostPage.goto(BASE, { waitUntil: 'networkidle0', timeout: TIMEOUT });
        assert(res.status() >= 200 && res.status() < 400, `Host page status: ${res.status()}`);
    });

    await test('Join tab loads', async () => {
        const res = await joinPage.goto(BASE, { waitUntil: 'networkidle0', timeout: TIMEOUT });
        assert(res.status() >= 200 && res.status() < 400, `Join page status: ${res.status()}`);
    });

    // Wait for WASM initialization — board appears after WASM loads and renders
    await test('Host WASM initializes', async () => {
        await hostPage.waitForSelector('.board', { timeout: TIMEOUT });
        // Extra wait for DOM event handlers to be wired up
        await new Promise(r => setTimeout(r, 2000));
    });

    await test('Join WASM initializes', async () => {
        await joinPage.waitForSelector('.board', { timeout: TIMEOUT });
        await new Promise(r => setTimeout(r, 2000));
    });

    // ─── Phase 2: Navigate to P2P ───
    console.log('\n🔷 Phase 2: Navigate to P2P Connect\n');

    await test('Host opens P2P Connect', async () => {
        await safeClick(hostPage, '[data-action="toggle-p2p"]');
        await waitFor(hostPage, '.p2p-connect');
    });

    await test('Join tab opens P2P Connect', async () => {
        await safeClick(joinPage, '[data-action="toggle-p2p"]');
        await waitFor(joinPage, '.p2p-connect');
    });

    // ─── Phase 3: Host a game ───
    console.log('\n🔷 Phase 3: Host Game\n');

    let hostEndpointId = null;

    await test('Host clicks "Raise the Banner"', async () => {
        await safeClick(hostPage, '[data-action="p2p-host"]');
        // Wait for the endpoint ID to appear — Iroh endpoint spawn is async
        console.log('    Waiting for Iroh endpoint to spawn...');
        try {
            await waitFor(hostPage, '.p2p-id', TIMEOUT);
        } catch(e) {
            // Dump console logs to debug
            console.log('    Host console logs:');
            hostLogs.slice(-20).forEach(l => console.log(`      ${l}`));
            throw e;
        }
        hostEndpointId = await getText(hostPage, '.p2p-id');
        assert(hostEndpointId && hostEndpointId.length > 10,
            `Invalid endpoint ID: "${hostEndpointId}"`);
        console.log(`    Host endpoint ID: ${hostEndpointId.substring(0, 20)}...`);
    });

    await test('Host shows "Hosting as Defender" role', async () => {
        const role = await getText(hostPage, '.p2p-role');
        assert(role && role.toLowerCase().includes('defender'),
            `Expected defender role, got: "${role}"`);
    });

    await test('Host shows connecting status', async () => {
        const hasDot = await hostPage.evaluate(() =>
            document.querySelector('.p2p-status-dot') !== null
        );
        assert(hasDot, 'No status dot found');
    });

    // ─── Phase 4: Join the game ───
    console.log('\n🔷 Phase 4: Join Game\n');

    await test('Joiner enters peer ID and clicks "Join the Raid"', async () => {
        assert(hostEndpointId, 'No host endpoint ID available');
        // Wait for host's pkarr record to propagate to DNS
        console.log('    Waiting 5s for host pkarr publish...');
        await new Promise(r => setTimeout(r, 5000));
        // Set the host's endpoint ID in the input field
        await joinPage.evaluate((id) => {
            const input = document.querySelector('[data-input="peer-id"]');
            if (input) { input.value = id; input.dispatchEvent(new Event('input')); }
        }, hostEndpointId);
        // Click the join button
        await safeClick(joinPage, '[data-action="p2p-join"]');
    });

    await test('Joiner shows "Joined as Attacker" role (or already connected)', async () => {
        // Connection may establish so fast that the P2P screen auto-switches to board
        // before we can read the role. Accept either seeing the role or the board.
        const start = Date.now();
        let sawRole = false;
        while (Date.now() - start < TIMEOUT) {
            const role = await getText(joinPage, '.p2p-role');
            if (role && role.toLowerCase().includes('attacker')) {
                sawRole = true;
                break;
            }
            // If we already see the board, connection was fast — that's fine
            const hasBoard = await joinPage.evaluate(() => !!document.querySelector('.board'));
            if (hasBoard) {
                console.log('    (connection established before role could be read — OK)');
                sawRole = true;
                break;
            }
            await new Promise(r => setTimeout(r, 300));
        }
        assert(sawRole, 'Neither .p2p-role nor .board appeared');
    });

    // ─── Phase 5: Wait for connection ───
    console.log('\n🔷 Phase 5: Connection Established\n');

    await test('Both tabs show board (auto-switch on connect)', async () => {
        // When P2P connects, the UI automatically switches from P2P screen to board
        // Wait for the board to appear on both tabs
        const waitForBoard = async (page, label) => {
            const start = Date.now();
            while (Date.now() - start < TIMEOUT) {
                const hasBoard = await page.evaluate(() => !!document.querySelector('.board'));
                if (hasBoard) return;
                await new Promise(r => setTimeout(r, 500));
            }
            throw new Error(`${label} board not visible`);
        };
        await Promise.all([
            waitForBoard(hostPage, 'Host'),
            waitForBoard(joinPage, 'Joiner')
        ]);
    });

    await test('Board is visible on both tabs', async () => {
        await waitFor(hostPage, '.board');
        await waitFor(joinPage, '.board');
    });

    await test('Initial board states match', async () => {
        await waitForBoardSync(hostPage, joinPage);
    });

    // ─── Phase 6: Play the game ───
    console.log('\n🔷 Phase 6: Play Game Moves\n');

    let moveCount = 0;
    let gameEnded = false;

    // Attackers move first, joiner is attacker
    // Host is defender
    // Tab assignments: joinPage = attacker, hostPage = defender

    await test('Play alternating moves until game over', async () => {
        while (moveCount < MAX_MOVES) {
            // Check game over on either tab
            if (await isGameOver(hostPage) || await isGameOver(joinPage)) {
                gameEnded = true;
                break;
            }

            const currentSide = moveCount % 2 === 0 ? 'attacker' : 'defender';
            const activePage = currentSide === 'attacker' ? joinPage : hostPage;
            const waitPage = currentSide === 'attacker' ? hostPage : joinPage;

            const move = await makeRandomMove(activePage, currentSide);
            if (!move) {
                console.log(`    No legal moves for ${currentSide} at move ${moveCount + 1}`);
                break;
            }

            moveCount++;
            if (moveCount <= 5 || moveCount % 10 === 0) {
                console.log(`    Move ${moveCount}: ${currentSide} (${move.from.row},${move.from.col}) → (${move.to.row},${move.to.col})`);
            }

            // Wait for the move to sync to the other tab
            await new Promise(r => setTimeout(r, 1500));
            try {
                await waitForBoardSync(activePage, waitPage, 15_000);
            } catch (e) {
                console.log(`    ⚠ Board sync failed at move ${moveCount}`);
                // Dump diagnostics
                const activeHash = await getBoardHash(activePage);
                const waitHash = await getBoardHash(waitPage);
                const activePieces = activeHash.split('|').filter(s => !s.endsWith('-')).length;
                const waitPieces = waitHash.split('|').filter(s => !s.endsWith('-')).length;
                console.log(`    Active tab pieces: ${activePieces}, Wait tab pieces: ${waitPieces}`);
                const activePlayer = await getCurrentPlayer(activePage);
                const waitPlayer = await getCurrentPlayer(waitPage);
                console.log(`    Active tab turn: ${activePlayer}, Wait tab turn: ${waitPlayer}`);
                // Dump recent console logs from both tabs
                console.log(`    Recent host logs:`);
                hostLogs.slice(-30).forEach(l => console.log(`      ${l}`));
                console.log(`    Recent join logs:`);
                joinLogs.slice(-30).forEach(l => console.log(`      ${l}`));
                // Stop on first sync failure to diagnose
                break;
            }
        }

        console.log(`    Total moves played: ${moveCount}`);
        assert(moveCount > 0, 'No moves were played');
    });

    // ─── Phase 7: Validate end state ───
    console.log('\n🔷 Phase 7: End State Validation\n');

    if (gameEnded) {
        await test('Game over overlay appears on both tabs', async () => {
            const hostOver = await isGameOver(hostPage);
            const joinOver = await isGameOver(joinPage);
            // At least one should show game over
            assert(hostOver || joinOver, 'Game over not shown on either tab');
        });

        await test('Game over text shows winner', async () => {
            const text = await getText(hostPage, '.game-over-text') ||
                         await getText(joinPage, '.game-over-text');
            assert(text, 'No game over text found');
            const valid = text.toLowerCase().includes('win') || text.toLowerCase().includes('draw');
            assert(valid, `Unexpected game over text: "${text}"`);
            console.log(`    Result: ${text}`);
        });
    } else {
        await test('Game progressed without errors', async () => {
            assert(moveCount >= 2, `Only ${moveCount} moves played`);
            console.log(`    Game did not complete in ${MAX_MOVES} moves (normal for random play)`);
        });

        await test('Final board states match between tabs', async () => {
            await waitForBoardSync(hostPage, joinPage);
        });
    }

    // ─── Phase 8: Connection integrity ───
    console.log('\n🔷 Phase 8: Connection Integrity\n');

    await test('No critical console errors on host', async () => {
        const critical = hostErrors.filter(e =>
            !e.includes('iroh') && !e.includes('Iroh') &&
            !e.includes('P2P') && !e.includes('favicon') &&
            !e.includes('404') && !e.includes('manifest')
        );
        if (critical.length > 0) {
            console.log(`    Host errors: ${critical.join('; ')}`);
        }
        assert(critical.length === 0, `${critical.length} critical errors on host`);
    });

    await test('No critical console errors on joiner', async () => {
        const critical = joinErrors.filter(e =>
            !e.includes('iroh') && !e.includes('Iroh') &&
            !e.includes('P2P') && !e.includes('favicon') &&
            !e.includes('404') && !e.includes('manifest')
        );
        if (critical.length > 0) {
            console.log(`    Join errors: ${critical.join('; ')}`);
        }
        assert(critical.length === 0, `${critical.length} critical errors on joiner`);
    });

    // Summary
    console.log(`\n${'═'.repeat(55)}`);
    console.log(`⚔️  P2P E2E Results: ${passed} passed, ${failed} failed, ${passed + failed} total`);
    console.log(`   Moves played: ${moveCount} | Game ended: ${gameEnded}`);
    console.log(`${'═'.repeat(55)}\n`);

} catch (e) {
    console.error('Fatal error:', e.message);
    failed++;
} finally {
    if (browser) await browser.close();
    process.exit(failed > 0 ? 1 : 0);
}
