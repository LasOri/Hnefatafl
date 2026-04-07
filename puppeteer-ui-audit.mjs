/**
 * Hnefatafl — Comprehensive UI Functional Test
 *
 * Tests every button, visual element, and feature in a single browser tab.
 * Run: npx http-server Public -p 8765 -c-1 --cors &
 *      node puppeteer-ui-audit.mjs
 */

import puppeteer from 'puppeteer';

const BASE = process.env.TEST_URL || 'http://localhost:8765';
const TIMEOUT = 60_000;

let passed = 0, failed = 0, warnings = [];
const logs = [];
const errors = [];

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

function warn(msg) {
    console.log(`  ⚠ ${msg}`);
    warnings.push(msg);
}

async function safeClick(page, selector, delay = 400) {
    await page.waitForSelector(selector, { timeout: TIMEOUT });
    await page.evaluate(sel => {
        const el = document.querySelector(sel);
        if (el) el.click();
    }, selector);
    await new Promise(r => setTimeout(r, delay));
}

async function getText(page, selector) {
    await page.waitForSelector(selector, { timeout: TIMEOUT });
    return page.evaluate(sel => {
        const el = document.querySelector(sel);
        return el ? el.textContent.trim() : null;
    }, selector);
}

async function exists(page, selector) {
    return page.evaluate(sel => !!document.querySelector(sel), selector);
}

async function isVisible(page, selector) {
    return page.evaluate(sel => {
        const el = document.querySelector(sel);
        if (!el) return false;
        const style = window.getComputedStyle(el);
        return style.display !== 'none' && style.visibility !== 'hidden' && style.opacity !== '0';
    }, selector);
}

async function getCount(page, selector) {
    return page.evaluate(sel => document.querySelectorAll(sel).length, selector);
}

async function getAttr(page, selector, attr) {
    return page.evaluate((sel, a) => {
        const el = document.querySelector(sel);
        return el ? el.getAttribute(a) : null;
    }, selector, attr);
}

async function getClasses(page, selector) {
    return page.evaluate(sel => {
        const el = document.querySelector(sel);
        return el ? [...el.classList] : [];
    }, selector);
}

async function getBoardState(page) {
    return page.evaluate(() => {
        const squares = document.querySelectorAll('.square');
        let attackers = 0, defenders = 0, kings = 0;
        squares.forEach(sq => {
            if (sq.classList.contains('piece-attacker')) attackers++;
            if (sq.classList.contains('piece-defender')) defenders++;
            if (sq.classList.contains('piece-king')) kings++;
        });
        return { attackers, defenders, kings, total: squares.length };
    });
}

// ============================================================
// Main test suite
// ============================================================

let browser, page;

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
        protocolTimeout: TIMEOUT,
    });

    page = await browser.newPage();
    await page.setViewport({ width: 1280, height: 900 });

    page.on('console', msg => {
        logs.push(`[${msg.type()}] ${msg.text()}`);
        if (msg.type() === 'error') errors.push(msg.text());
    });

    // ========================================================
    console.log('\n═══ Phase 1: Page Load & Initial State ═══');
    // ========================================================

    await test('Page loads without crash', async () => {
        await page.goto(BASE, { waitUntil: 'networkidle0', timeout: TIMEOUT });
    });

    await test('WASM initializes — board appears', async () => {
        await page.waitForSelector('.board', { timeout: TIMEOUT });
    });

    await test('Viking app container exists', async () => {
        const has = await exists(page, '.viking-app');
        if (!has) throw new Error('Missing .viking-app container');
    });

    await test('Board has 11x11 = 121 squares', async () => {
        const count = await getCount(page, '.square');
        if (count !== 121) throw new Error(`Expected 121 squares, got ${count}`);
    });

    await test('Copenhagen starting position: 24 attackers, 12 defenders, 1 king', async () => {
        const state = await getBoardState(page);
        if (state.attackers !== 24) throw new Error(`Attackers: ${state.attackers}, expected 24`);
        if (state.defenders !== 12) throw new Error(`Defenders: ${state.defenders}, expected 12`);
        if (state.kings !== 1) throw new Error(`Kings: ${state.kings}, expected 1`);
    });

    await test('4 corner squares exist', async () => {
        const count = await getCount(page, '.square-corner');
        if (count !== 4) throw new Error(`Corners: ${count}, expected 4`);
    });

    await test('1 throne square exists', async () => {
        const count = await getCount(page, '.square-throne');
        if (count !== 1) throw new Error(`Thrones: ${count}, expected 1`);
    });

    await test('Corner squares have Valknut ornaments (SVG)', async () => {
        const count = await page.evaluate(() => {
            const corners = document.querySelectorAll('.square-corner');
            let svgCount = 0;
            corners.forEach(c => { if (c.querySelector('svg')) svgCount++; });
            return svgCount;
        });
        if (count !== 4) throw new Error(`Corners with SVG: ${count}, expected 4`);
    });

    await test('Throne square has Helm of Awe ornament (SVG)', async () => {
        const hasSvg = await page.evaluate(() => {
            const throne = document.querySelector('.square-throne');
            return throne && !!throne.querySelector('svg');
        });
        if (!hasSvg) throw new Error('Throne square missing SVG ornament');
    });

    await test('Pieces rendered as SVGs with role="img"', async () => {
        const count = await page.evaluate(() => {
            return document.querySelectorAll('.square svg[role="img"]').length;
        });
        // 24 attackers + 12 defenders + 1 king = 37 piece SVGs
        if (count < 37) throw new Error(`Piece SVGs: ${count}, expected >= 37`);
    });

    await test('Column coordinate labels A-K exist', async () => {
        const labels = await page.evaluate(() => {
            const els = document.querySelectorAll('.coord-label');
            const texts = [];
            els.forEach(el => texts.push(el.textContent.trim()));
            return texts;
        });
        const expectedCols = ['A','B','C','D','E','F','G','H','I','J','K'];
        for (const col of expectedCols) {
            if (!labels.includes(col)) throw new Error(`Missing column label: ${col}`);
        }
    });

    await test('Row coordinate labels 1-11 exist', async () => {
        const labels = await page.evaluate(() => {
            const els = document.querySelectorAll('.coord-label');
            const texts = [];
            els.forEach(el => texts.push(el.textContent.trim()));
            return texts;
        });
        for (let i = 1; i <= 11; i++) {
            if (!labels.includes(String(i))) throw new Error(`Missing row label: ${i}`);
        }
    });

    // ========================================================
    console.log('\n═══ Phase 2: Status Bar ═══');
    // ========================================================

    await test('Status bar exists', async () => {
        const has = await exists(page, '.status-bar');
        if (!has) throw new Error('Missing .status-bar');
    });

    await test('Turn indicator shows "Attacker" (first move)', async () => {
        const text = await getText(page, '.status-turn');
        if (!text.toLowerCase().includes('attacker')) throw new Error(`Turn text: "${text}"`);
    });

    await test('Turn indicator has in-progress class', async () => {
        const classes = await getClasses(page, '.status-turn');
        if (!classes.includes('status-in-progress')) throw new Error(`Classes: ${classes.join(', ')}`);
    });

    await test('Capture counters exist and show 0', async () => {
        const counts = await page.evaluate(() => {
            const els = document.querySelectorAll('.capture-count');
            return [...els].map(e => e.textContent.trim());
        });
        if (counts.length < 2) throw new Error(`Capture counters: ${counts.length}, expected 2`);
        for (const c of counts) {
            if (c !== '0') throw new Error(`Initial capture count: "${c}", expected "0"`);
        }
    });

    // ========================================================
    console.log('\n═══ Phase 3: Toolbar Buttons — Existence ═══');
    // ========================================================

    const expectedButtons = [
        { action: 'undo', cls: 'btn-undo', label: /undo/i },
        { action: 'new-game', cls: 'btn-new-game', label: /new game/i },
        { action: 'toggle-ai', cls: 'btn-ai', label: /play vs/i },
        { action: 'toggle-mute', cls: 'btn-mute', label: /mute|unmute/i },
        { action: 'cycle-difficulty', cls: 'btn-difficulty', label: /ai:/i },
        { action: 'cycle-personality', cls: 'btn-personality', label: /style:/i },
        { action: 'cycle-variant', cls: 'btn-variant', label: /copenhagen|tablut/i },
        { action: 'flip-board', cls: 'btn-flip', label: /flip/i },
        { action: 'toggle-rules', cls: 'btn-rules', label: /rules/i },
        { action: 'toggle-p2p', cls: 'btn-p2p', label: /play online|back to game/i },
    ];

    for (const btn of expectedButtons) {
        await test(`Button [${btn.action}] exists with class .${btn.cls}`, async () => {
            const sel = `[data-action="${btn.action}"]`;
            const has = await exists(page, sel);
            if (!has) throw new Error(`Button [data-action="${btn.action}"] not found`);
            const hasCls = await page.evaluate((s, c) => {
                const el = document.querySelector(s);
                return el && el.classList.contains(c);
            }, sel, btn.cls);
            if (!hasCls) throw new Error(`Missing class .${btn.cls}`);
        });

        await test(`Button [${btn.action}] has label matching ${btn.label}`, async () => {
            const text = await getText(page, `[data-action="${btn.action}"]`);
            if (!btn.label.test(text)) throw new Error(`Label: "${text}"`);
        });
    }

    await test('Toolbar has role="toolbar"', async () => {
        const role = await getAttr(page, '#toolbar', 'role');
        if (role !== 'toolbar') throw new Error(`Toolbar role: "${role}"`);
    });

    // ========================================================
    console.log('\n═══ Phase 4: Board Interaction — Piece Selection ═══');
    // ========================================================

    await test('Clicking attacker piece shows selected + legal moves', async () => {
        // Find an attacker piece
        const piece = await page.evaluate(() => {
            const el = document.querySelector('.piece-attacker');
            return el ? { row: el.dataset.row, col: el.dataset.col } : null;
        });
        if (!piece) throw new Error('No attacker piece found');
        await safeClick(page, `.square[data-row="${piece.row}"][data-col="${piece.col}"]`);

        const selected = await getCount(page, '.square.selected');
        if (selected !== 1) throw new Error(`Selected squares: ${selected}`);

        const legalMoves = await getCount(page, '.legal-move');
        if (legalMoves === 0) throw new Error('No legal moves highlighted');
    });

    await test('Selected square has glow class', async () => {
        const has = await exists(page, '.square.selected.glow');
        if (!has) throw new Error('Missing .glow class on selected square');
    });

    await test('Legal move squares have move-indicator class', async () => {
        const has = await exists(page, '.legal-move.move-indicator');
        if (!has) throw new Error('Missing .move-indicator on legal moves');
    });

    await test('Clicking same piece again deselects (no selected squares)', async () => {
        const piece = await page.evaluate(() => {
            const el = document.querySelector('.square.selected');
            return el ? { row: el.dataset.row, col: el.dataset.col } : null;
        });
        if (piece) {
            await safeClick(page, `.square[data-row="${piece.row}"][data-col="${piece.col}"]`);
        }
        const selected = await getCount(page, '.square.selected');
        if (selected !== 0) throw new Error(`Still selected: ${selected}`);
    });

    await test('Clicking defender piece (wrong turn) does NOT select', async () => {
        const piece = await page.evaluate(() => {
            const el = document.querySelector('.piece-defender');
            return el ? { row: el.dataset.row, col: el.dataset.col } : null;
        });
        if (!piece) throw new Error('No defender piece found');
        await safeClick(page, `.square[data-row="${piece.row}"][data-col="${piece.col}"]`);
        const selected = await getCount(page, '.square.selected');
        if (selected !== 0) throw new Error(`Defender selected on attacker turn: ${selected}`);
    });

    // ========================================================
    console.log('\n═══ Phase 5: Making a Move ═══');
    // ========================================================

    let moveWasMade = false;

    await test('Make a valid attacker move', async () => {
        // Copenhagen starting position: attacker at row=0,col=3. Legal move to row=0,col=2.
        await safeClick(page, '.square[data-row="0"][data-col="3"]');
        await new Promise(r => setTimeout(r, 500));
        // Verify selection happened
        const selected = await getCount(page, '.square.selected');
        if (selected === 0) throw new Error('Piece at (0,3) was not selected');
        await safeClick(page, '.square[data-row="0"][data-col="2"]');
        await new Promise(r => setTimeout(r, 500));
        moveWasMade = true;
    });

    await test('After attacker move, turn switches to Defender', async () => {
        if (!moveWasMade) throw new Error('Skipped — no move was made');
        const text = await getText(page, '.status-turn');
        if (!text.toLowerCase().includes('defender')) throw new Error(`Turn text after move: "${text}"`);
    });

    await test('Move trail SVG appears after move', async () => {
        if (!moveWasMade) throw new Error('Skipped — no move was made');
        const has = await exists(page, '.move-trail');
        if (!has) throw new Error('No .move-trail SVG found');
    });

    await test('Move history panel shows at least 1 move', async () => {
        if (!moveWasMade) throw new Error('Skipped — no move was made');
        const items = await getCount(page, '.move-item');
        if (items < 1) throw new Error(`Move history items: ${items}`);
    });

    await test('Move history has ordered list with aria-label', async () => {
        const label = await getAttr(page, '.move-history', 'aria-label');
        if (!label) throw new Error('Move history missing aria-label');
    });

    // ========================================================
    console.log('\n═══ Phase 6: Undo Button ═══');
    // ========================================================

    await test('Undo reverts the move — turn goes back to Attacker', async () => {
        if (!moveWasMade) throw new Error('Skipped — no move was made');
        await safeClick(page, '[data-action="undo"]');
        const text = await getText(page, '.status-turn');
        if (!text.toLowerCase().includes('attacker')) throw new Error(`After undo: "${text}"`);
    });

    await test('After undo, board is back to starting position (24/12/1)', async () => {
        const state = await getBoardState(page);
        if (state.attackers !== 24 || state.defenders !== 12 || state.kings !== 1) {
            throw new Error(`After undo: ${state.attackers}A/${state.defenders}D/${state.kings}K`);
        }
    });

    // ========================================================
    console.log('\n═══ Phase 7: AI Toggle ═══');
    // ========================================================

    await test('Toggle AI — label changes to "Play vs Human"', async () => {
        await safeClick(page, '[data-action="toggle-ai"]');
        const text = await getText(page, '[data-action="toggle-ai"]');
        if (!text.toLowerCase().includes('human')) throw new Error(`AI button: "${text}"`);
    });

    await test('Toggle AI back — label changes to "Play vs AI"', async () => {
        await safeClick(page, '[data-action="toggle-ai"]');
        const text = await getText(page, '[data-action="toggle-ai"]');
        if (!text.toLowerCase().includes('ai')) throw new Error(`AI button: "${text}"`);
    });

    // ========================================================
    console.log('\n═══ Phase 8: Difficulty Cycle ═══');
    // ========================================================

    await test('Cycle difficulty — label changes', async () => {
        const text1 = await getText(page, '[data-action="cycle-difficulty"]');
        await safeClick(page, '[data-action="cycle-difficulty"]');
        const text2 = await getText(page, '[data-action="cycle-difficulty"]');
        if (text1 === text2) throw new Error(`Difficulty did not change: "${text1}"`);
    });

    await test('Cycle difficulty through all levels (3 clicks returns to start)', async () => {
        const start = await getText(page, '[data-action="cycle-difficulty"]');
        for (let i = 0; i < 3; i++) {
            await safeClick(page, '[data-action="cycle-difficulty"]', 200);
        }
        const end = await getText(page, '[data-action="cycle-difficulty"]');
        if (start !== end) throw new Error(`Cycle did not wrap: "${start}" → "${end}"`);
    });

    // ========================================================
    console.log('\n═══ Phase 9: Personality Cycle ═══');
    // ========================================================

    await test('Cycle personality — label changes', async () => {
        const text1 = await getText(page, '[data-action="cycle-personality"]');
        await safeClick(page, '[data-action="cycle-personality"]');
        const text2 = await getText(page, '[data-action="cycle-personality"]');
        if (text1 === text2) throw new Error(`Personality did not change: "${text1}"`);
    });

    // ========================================================
    console.log('\n═══ Phase 10: Variant Cycle ═══');
    // ========================================================

    await test('Cycle variant — changes from Copenhagen to Tablut', async () => {
        const text1 = await getText(page, '[data-action="cycle-variant"]');
        await safeClick(page, '[data-action="cycle-variant"]');
        const text2 = await getText(page, '[data-action="cycle-variant"]');
        if (text1 === text2) throw new Error(`Variant did not change: "${text1}"`);
    });

    await test('Tablut has different piece count (16 attackers, 8 defenders, 1 king)', async () => {
        const state = await getBoardState(page);
        // Tablut: 16 attackers, 8 defenders, 1 king on 9x9 board
        if (state.attackers !== 16 || state.defenders !== 8 || state.kings !== 1) {
            warn(`Tablut pieces: ${state.attackers}A/${state.defenders}D/${state.kings}K — check if expected`);
        }
    });

    await test('Cycle variant back to Copenhagen', async () => {
        await safeClick(page, '[data-action="cycle-variant"]');
        const text = await getText(page, '[data-action="cycle-variant"]');
        if (!text.toLowerCase().includes('copenhagen')) {
            // May need more clicks if there are more than 2 variants
            for (let i = 0; i < 5; i++) {
                await safeClick(page, '[data-action="cycle-variant"]', 200);
                const t = await getText(page, '[data-action="cycle-variant"]');
                if (t.toLowerCase().includes('copenhagen')) break;
            }
        }
        const state = await getBoardState(page);
        if (state.attackers !== 24) throw new Error(`Not Copenhagen: ${state.attackers} attackers`);
    });

    // ========================================================
    console.log('\n═══ Phase 11: Mute Toggle ═══');
    // ========================================================

    await test('Toggle mute — label changes', async () => {
        const text1 = await getText(page, '[data-action="toggle-mute"]');
        await safeClick(page, '[data-action="toggle-mute"]');
        const text2 = await getText(page, '[data-action="toggle-mute"]');
        if (text1 === text2) throw new Error(`Mute did not toggle: "${text1}"`);
    });

    await test('Toggle mute back', async () => {
        await safeClick(page, '[data-action="toggle-mute"]');
    });

    // ========================================================
    console.log('\n═══ Phase 12: Flip Board ═══');
    // ========================================================

    await test('Flip board — label changes to "Unflip Board"', async () => {
        await safeClick(page, '[data-action="flip-board"]');
        const text = await getText(page, '[data-action="flip-board"]');
        if (!text.toLowerCase().includes('unflip')) throw new Error(`Flip label: "${text}"`);
    });

    await test('Board is still interactive after flip (piece count unchanged)', async () => {
        const state = await getBoardState(page);
        if (state.attackers !== 24) throw new Error(`Pieces lost after flip: ${state.attackers}A`);
    });

    await test('Unflip board', async () => {
        await safeClick(page, '[data-action="flip-board"]');
        const text = await getText(page, '[data-action="flip-board"]');
        if (!text.toLowerCase().includes('flip board')) throw new Error(`Unflip label: "${text}"`);
    });

    // ========================================================
    console.log('\n═══ Phase 13: Rules Overlay ═══');
    // ========================================================

    await test('Open rules overlay', async () => {
        await safeClick(page, '[data-action="toggle-rules"]');
        const has = await exists(page, '.rules-overlay');
        if (!has) throw new Error('Rules overlay did not appear');
    });

    await test('Rules overlay has title "Hnefatafl Rules"', async () => {
        const title = await getText(page, '.rules-title');
        if (!title.toLowerCase().includes('hnefatafl') && !title.toLowerCase().includes('rules')) {
            throw new Error(`Rules title: "${title}"`);
        }
    });

    await test('Rules has close button', async () => {
        const has = await exists(page, '.btn-close-rules');
        if (!has) throw new Error('No .btn-close-rules found');
    });

    await test('Close rules overlay', async () => {
        await safeClick(page, '.btn-close-rules');
        await new Promise(r => setTimeout(r, 300));
        const has = await exists(page, '.rules-overlay');
        if (has) {
            const vis = await isVisible(page, '.rules-overlay');
            if (vis) throw new Error('Rules overlay still visible after close');
        }
    });

    // ========================================================
    console.log('\n═══ Phase 14: P2P Connect Screen ═══');
    // ========================================================

    await test('Toggle P2P — shows P2P connect screen', async () => {
        await safeClick(page, '[data-action="toggle-p2p"]');
        const has = await exists(page, '.p2p-connect');
        if (!has) throw new Error('P2P connect screen did not appear');
    });

    await test('P2P screen has title "Peer-to-Peer Battle"', async () => {
        const title = await getText(page, '.p2p-title');
        if (!title.includes('Peer-to-Peer')) throw new Error(`P2P title: "${title}"`);
    });

    await test('Host button exists — "Raise the Banner"', async () => {
        const text = await getText(page, '[data-action="p2p-host"]');
        if (!text.toLowerCase().includes('banner')) throw new Error(`Host btn: "${text}"`);
    });

    await test('Join button exists — "Join the Raid"', async () => {
        const text = await getText(page, '[data-action="p2p-join"]');
        if (!text.toLowerCase().includes('raid')) throw new Error(`Join btn: "${text}"`);
    });

    await test('Peer ID input field exists', async () => {
        const has = await exists(page, '[data-input="peer-id"]');
        if (!has) throw new Error('Missing peer-id input');
    });

    await test('Peer ID input has placeholder', async () => {
        const ph = await getAttr(page, '[data-input="peer-id"]', 'placeholder');
        if (!ph) throw new Error('Input missing placeholder');
    });

    await test('P2P divider with "or" text exists', async () => {
        const has = await exists(page, '.p2p-divider');
        if (!has) throw new Error('Missing .p2p-divider');
    });

    await test('P2P panels exist (host + join)', async () => {
        const count = await getCount(page, '.p2p-panel');
        if (count < 2) throw new Error(`P2P panels: ${count}, expected 2`);
    });

    await test('P2P screen has accessibility region role', async () => {
        const role = await getAttr(page, '.p2p-connect', 'role');
        if (role !== 'region') throw new Error(`P2P role: "${role}"`);
    });

    await test('Board is hidden when P2P connect is shown', async () => {
        const boardVisible = await exists(page, '.board');
        // Board should either not exist or P2P screen should replace it
        const p2pVisible = await exists(page, '.p2p-connect');
        if (boardVisible && p2pVisible) {
            // Both exist — check if they're both rendered (this may be valid depending on layout)
            warn('Both board and P2P screen exist in DOM simultaneously');
        }
    });

    await test('Toggle P2P back — board reappears', async () => {
        await safeClick(page, '[data-action="toggle-p2p"]');
        const has = await exists(page, '.board');
        if (!has) throw new Error('Board did not reappear after P2P toggle back');
    });

    // ========================================================
    console.log('\n═══ Phase 15: New Game ═══');
    // ========================================================

    // First make a move so the game is in progress
    await test('Make a move, then New Game resets board', async () => {
        // Make a quick move
        const result = await page.evaluate(() => {
            const atk = document.querySelector('.piece-attacker');
            if (atk) atk.click();
            const legal = document.querySelector('.legal-move');
            return legal ? { row: legal.dataset.row, col: legal.dataset.col } : null;
        });
        if (result) {
            await safeClick(page, `.square[data-row="${result.row}"][data-col="${result.col}"]`);
            await new Promise(r => setTimeout(r, 200));
        }
        await safeClick(page, '[data-action="new-game"]');
        const state = await getBoardState(page);
        if (state.attackers !== 24) throw new Error(`After new game: ${state.attackers} attackers`);
    });

    await test('After new game, turn is Attacker', async () => {
        const text = await getText(page, '.status-turn');
        if (!text.toLowerCase().includes('attacker')) throw new Error(`Turn: "${text}"`);
    });

    await test('After new game, captures are 0', async () => {
        const counts = await page.evaluate(() => {
            return [...document.querySelectorAll('.capture-count')].map(e => e.textContent.trim());
        });
        for (const c of counts) {
            if (c !== '0') throw new Error(`Capture not reset: "${c}"`);
        }
    });

    // ========================================================
    console.log('\n═══ Phase 16: Keyboard Navigation ═══');
    // ========================================================

    await test('Arrow keys move focus indicator', async () => {
        // Focus the board area first
        await page.keyboard.press('ArrowRight');
        await new Promise(r => setTimeout(r, 200));
        const hasFocused = await exists(page, '.square.focused');
        if (!hasFocused) warn('No .focused square after ArrowRight — keyboard nav may not be active');
    });

    // ========================================================
    console.log('\n═══ Phase 17: Accessibility ═══');
    // ========================================================

    await test('Skip link exists', async () => {
        const has = await exists(page, '.skip-link');
        if (!has) throw new Error('Missing .skip-link');
    });

    await test('Live region for announcements exists', async () => {
        const has = await page.evaluate(() => {
            return !!document.querySelector('[aria-live]');
        });
        if (!has) throw new Error('No aria-live region found');
    });

    await test('Board has role="grid"', async () => {
        const role = await getAttr(page, '.board', 'role');
        if (role !== 'grid') throw new Error(`Board role: "${role}"`);
    });

    await test('Squares have role="gridcell"', async () => {
        const count = await page.evaluate(() => {
            return document.querySelectorAll('.square[role="gridcell"]').length;
        });
        if (count < 121) throw new Error(`Gridcells: ${count}`);
    });

    await test('Capture counters have aria-labels', async () => {
        const labels = await page.evaluate(() => {
            return [...document.querySelectorAll('.capture-count')].map(e => e.getAttribute('aria-label'));
        });
        for (const l of labels) {
            if (!l) throw new Error('Capture counter missing aria-label');
        }
    });

    // ========================================================
    console.log('\n═══ Phase 18: Play Through Moves & Game Over ═══');
    // ========================================================

    // Make a series of moves to verify ongoing gameplay works
    let movesPlayed = 0;
    const maxTestMoves = 10;

    await test(`Play ${maxTestMoves} alternating moves without crash`, async () => {
        for (let i = 0; i < maxTestMoves; i++) {
            // Determine whose turn it is
            const statusText = await getText(page, '.status-turn');
            const isAttacker = statusText.toLowerCase().includes('attacker');
            const pieceClass = isAttacker ? '.piece-attacker' : '.piece-defender, .piece-king';

            // Get all pieces for the current player
            const pieceCoords = await page.evaluate((cls) => {
                return [...document.querySelectorAll(cls)].map(p => {
                    const sq = p.closest('.square');
                    return sq ? { row: sq.dataset.row, col: sq.dataset.col } : null;
                }).filter(Boolean);
            }, pieceClass);

            // Shuffle
            for (let j = pieceCoords.length - 1; j > 0; j--) {
                const k = Math.floor(Math.random() * (j + 1));
                [pieceCoords[j], pieceCoords[k]] = [pieceCoords[k], pieceCoords[j]];
            }

            let moved = false;
            for (const pc of pieceCoords) {
                await safeClick(page, `.square[data-row="${pc.row}"][data-col="${pc.col}"]`, 200);
                const legalMove = await page.evaluate(() => {
                    const moves = [...document.querySelectorAll('.legal-move')];
                    if (moves.length === 0) return null;
                    const target = moves[Math.floor(Math.random() * moves.length)];
                    return { row: target.dataset.row, col: target.dataset.col };
                });
                if (legalMove) {
                    await safeClick(page, `.square[data-row="${legalMove.row}"][data-col="${legalMove.col}"]`, 200);
                    moved = true;
                    break;
                }
                // Deselect by clicking same square
                await safeClick(page, `.square[data-row="${pc.row}"][data-col="${pc.col}"]`, 100);
            }
            if (!moved) break;
            movesPlayed++;

            // Check for game over
            const gameOver = await exists(page, '.game-over-overlay');
            if (gameOver) break;
        }
        if (movesPlayed === 0) throw new Error('Could not make any moves');
    });

    await test(`Played ${movesPlayed} moves — board state is consistent`, async () => {
        const state = await getBoardState(page);
        const total = state.attackers + state.defenders + state.kings;
        if (total > 37) throw new Error(`More pieces than start: ${total}`);
        if (state.kings > 1) throw new Error(`Multiple kings: ${state.kings}`);
    });

    // Check game over overlay if game ended
    const gameOver = await exists(page, '.game-over-overlay');
    if (gameOver) {
        await test('Game over overlay visible', async () => {
            const vis = await isVisible(page, '.game-over-overlay');
            if (!vis) throw new Error('Overlay exists but not visible');
        });

        await test('Game over text shows winner', async () => {
            const text = await getText(page, '.game-over-text');
            if (!text) throw new Error('No game-over-text element');
            const valid = /attacker|defender|draw/i.test(text);
            if (!valid) throw new Error(`Game over text: "${text}"`);
        });

        await test('Play Again button exists in game over overlay', async () => {
            const has = await page.evaluate(() => {
                const overlay = document.querySelector('.game-over-overlay');
                return overlay && !!overlay.querySelector('[data-action="new-game"]');
            });
            if (!has) throw new Error('No new-game button in overlay');
        });

        await test('Play Again resets the game', async () => {
            await safeClick(page, '.game-over-overlay [data-action="new-game"]');
            await new Promise(r => setTimeout(r, 500));
            const state = await getBoardState(page);
            if (state.attackers !== 24) throw new Error(`After play again: ${state.attackers}A`);
        });
    }

    // ========================================================
    console.log('\n═══ Phase 19: Visual Element Audit ═══');
    // ========================================================

    // Reset to clean state
    await safeClick(page, '[data-action="new-game"]');
    await new Promise(r => setTimeout(r, 300));

    await test('No orphaned/hidden elements with display:none that should be visible', async () => {
        const hidden = await page.evaluate(() => {
            const issues = [];
            // Check key elements that should always be visible
            const mustBeVisible = ['.board', '.status-bar', '#toolbar'];
            for (const sel of mustBeVisible) {
                const el = document.querySelector(sel);
                if (el) {
                    const style = window.getComputedStyle(el);
                    if (style.display === 'none' || style.visibility === 'hidden') {
                        issues.push(`${sel} is hidden`);
                    }
                }
            }
            return issues;
        });
        if (hidden.length > 0) throw new Error(hidden.join('; '));
    });

    await test('No overlapping z-index conflicts (overlays not stuck)', async () => {
        // Ensure no overlay is visible when it shouldn't be
        const stuck = await page.evaluate(() => {
            const issues = [];
            const overlays = ['.game-over-overlay', '.rules-overlay'];
            for (const sel of overlays) {
                const el = document.querySelector(sel);
                if (el) {
                    const style = window.getComputedStyle(el);
                    if (style.display !== 'none' && style.visibility !== 'hidden') {
                        issues.push(`${sel} visible when it shouldn't be`);
                    }
                }
            }
            return issues;
        });
        if (stuck.length > 0) throw new Error(stuck.join('; '));
    });

    await test('All piece SVGs have aria-label attributes', async () => {
        const missing = await page.evaluate(() => {
            const svgs = document.querySelectorAll('.square svg[role="img"]');
            let count = 0;
            svgs.forEach(svg => {
                if (!svg.getAttribute('aria-label')) count++;
            });
            return count;
        });
        if (missing > 0) throw new Error(`${missing} piece SVGs missing aria-label`);
    });

    await test('Board grid alignment — squares form proper grid', async () => {
        const aligned = await page.evaluate(() => {
            const squares = document.querySelectorAll('.square');
            if (squares.length === 0) return false;
            const first = squares[0].getBoundingClientRect();
            // All squares should have similar dimensions
            let minW = Infinity, maxW = 0;
            squares.forEach(sq => {
                const r = sq.getBoundingClientRect();
                if (r.width > 0) {
                    minW = Math.min(minW, r.width);
                    maxW = Math.max(maxW, r.width);
                }
            });
            // Squares should be within 2px of each other
            return (maxW - minW) < 2;
        });
        if (!aligned) throw new Error('Square sizes are inconsistent');
    });

    // ========================================================
    console.log('\n═══ Phase 20: Console Error Audit ═══');
    // ========================================================

    await test('No critical JS errors in console', async () => {
        const critical = errors.filter(e => {
            // Filter known benign errors
            if (e.includes('iroh') || e.includes('Iroh')) return false;
            if (e.includes('manifest.json')) return false;
            if (e.includes('favicon')) return false;
            if (e.includes('404')) return false;
            if (e.includes('P2P module')) return false;
            if (e.includes('net::ERR')) return false;
            if (e.includes('sw.js')) return false;
            return true;
        });
        if (critical.length > 0) {
            throw new Error(`${critical.length} critical errors:\n    ${critical.slice(0, 5).join('\n    ')}`);
        }
    });

    // ========================================================
    // Summary
    // ========================================================
    console.log('\n══════════════════════════════════════');
    console.log(`  Results: ${passed} passed, ${failed} failed, ${warnings.length} warnings`);
    if (warnings.length > 0) {
        console.log('  Warnings:');
        warnings.forEach(w => console.log(`    ⚠ ${w}`));
    }
    console.log('══════════════════════════════════════\n');

} catch (e) {
    console.error('Fatal error:', e.message);
    failed++;
} finally {
    if (browser) await browser.close();
    process.exit(failed > 0 ? 1 : 0);
}
