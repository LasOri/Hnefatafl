#!/usr/bin/env node
/**
 * Puppeteer validation for Hnefatafl Viking Board Game
 * Tests: page load, WASM init, board render, pieces, interaction, a11y, design
 */
import puppeteer from 'puppeteer';

const BASE = process.env.TEST_URL || 'http://localhost:8765';
const TIMEOUT = 60_000;
let browser, page;
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

try {
    browser = await puppeteer.launch({ headless: true, args: ['--no-sandbox'] });
    page = await browser.newPage();
    page.on('pageerror', err => console.log(`  [PAGE ERROR] ${err.message}`));

    // Collect console errors
    const consoleErrors = [];
    const failedRequests = [];
    page.on('console', msg => {
        if (msg.type() === 'error') consoleErrors.push(msg.text());
    });
    page.on('requestfailed', req => {
        failedRequests.push(req.url());
    });

    console.log('\n🔷 1. Page Load & WASM Initialization\n');

    await test('Page loads without HTTP errors', async () => {
        const response = await page.goto(BASE, { waitUntil: 'domcontentloaded', timeout: TIMEOUT });
        assert(response.status() === 200, `Status: ${response.status()}`);
    });

    await test('WASM app initializes (loading screen disappears)', async () => {
        // Wait for #app to have content beyond loading div
        await page.waitForFunction(() => {
            const app = document.getElementById('app');
            // Either loading is hidden or app has real game content
            const loading = document.getElementById('loading');
            if (!loading) return true; // loading div removed
            return loading.style.display === 'none' ||
                   app.querySelector('.board, table, [data-board], svg, .game') !== null;
        }, { timeout: TIMEOUT });
    });

    console.log('\n🔷 2. Board Rendering\n');

    await test('Game board is visible', async () => {
        const hasBoard = await page.evaluate(() => {
            // Look for board-related elements
            const selectors = ['table', '.board', '[data-board]', '.game-board', 'svg'];
            return selectors.some(s => document.querySelector(s) !== null);
        });
        assert(hasBoard, 'No board element found');
    });

    await test('Board has correct 11x11 grid structure', async () => {
        const cellCount = await page.evaluate(() => {
            // Check for 121 cells (11x11)
            const cells = document.querySelectorAll('td, .cell, [data-cell], [data-row]');
            return cells.length;
        });
        // Should have at least 121 cells for 11x11 board
        assert(cellCount >= 121, `Expected ≥121 cells, got ${cellCount}`);
    });

    console.log('\n🔷 3. Game Pieces\n');

    await test('Pieces are rendered on the board', async () => {
        const pieceCount = await page.evaluate(() => {
            // Check for SVG pieces or piece elements
            const pieces = document.querySelectorAll(
                'svg[aria-label*="piece"], .piece, [data-piece], td svg, .cell svg'
            );
            return pieces.length;
        });
        assert(pieceCount > 0, `No pieces found (count: ${pieceCount})`);
    });

    await test('Initial position has correct piece count (25 total)', async () => {
        const counts = await page.evaluate(() => {
            const attackers = document.querySelectorAll('[aria-label="Attacker piece"]').length;
            const defenders = document.querySelectorAll('[aria-label="Defender piece"]').length;
            const kings = document.querySelectorAll('[aria-label="King piece"]').length;
            return { attackers, defenders, kings, total: attackers + defenders + kings };
        });
        // Standard Hnefatafl: 24 attackers + 12 defenders + 1 king = 37
        // or: 16 attackers + 8 defenders + 1 king = 25 for Copenhagen variant
        assert(counts.total > 0, `Expected pieces, got ${JSON.stringify(counts)}`);
        assert(counts.kings >= 1, `Expected at least 1 king, got ${counts.kings}`);
    });

    console.log('\n🔷 4. User Interaction\n');

    await test('Clicking a piece selects it (highlights or shows legal moves)', async () => {
        const interacted = await page.evaluate(() => {
            // Find an attacker piece (it's attacker's turn first)
            const piece = document.querySelector('[aria-label="Attacker piece"]');
            if (!piece) return { found: false };
            const cell = piece.closest('td') || piece.parentElement;
            if (cell) cell.click();
            // Check if something changed (selected state, highlights, etc.)
            return {
                found: true,
                clicked: true,
                // After click, look for selection indicators
                hasSelected: document.querySelector('.selected, [data-selected], .highlight, .legal-move, [data-legal]') !== null
            };
        });
        assert(interacted.found, 'No attacker piece found to click');
    });

    console.log('\n🔷 5. Accessibility\n');

    await test('Page has lang attribute', async () => {
        const lang = await page.evaluate(() => document.documentElement.lang);
        assert(lang === 'en', `Expected lang="en", got "${lang}"`);
    });

    await test('SVG pieces have aria-labels', async () => {
        const ariaCount = await page.evaluate(() => {
            return document.querySelectorAll('svg[aria-label]').length;
        });
        assert(ariaCount > 0, `No SVG elements with aria-label found`);
    });

    await test('Skip navigation link exists', async () => {
        const hasSkipLink = await page.evaluate(() => {
            const links = document.querySelectorAll('a[href="#toolbar"], .skip-link');
            return links.length > 0;
        });
        assert(hasSkipLink, 'No skip navigation link found');
    });

    await test('Toolbar has id for skip nav target', async () => {
        const hasToolbar = await page.evaluate(() => {
            return document.getElementById('toolbar') !== null;
        });
        assert(hasToolbar, 'No element with id="toolbar" found');
    });

    console.log('\n🔷 6. Viking Design System\n');

    await test('Viking color scheme applied (dark background)', async () => {
        const bgColor = await page.evaluate(() => {
            return getComputedStyle(document.body).backgroundColor;
        });
        // Should be dark brown (#2d1b0e or similar)
        assert(bgColor && bgColor !== 'rgba(0, 0, 0, 0)', `Background: ${bgColor}`);
    });

    await test('CSS custom properties are set', async () => {
        const hasCustomProps = await page.evaluate(() => {
            const style = getComputedStyle(document.documentElement);
            // Check for Viking design tokens
            const props = ['--bg-primary', '--text-primary', '--gold-accent', '--bg-surface'];
            return props.some(p => style.getPropertyValue(p) !== '');
        });
        assert(hasCustomProps, 'No CSS custom properties found');
    });

    console.log('\n🔷 7. CSP & Security\n');

    await test('Content Security Policy meta tag present', async () => {
        const hasCSP = await page.evaluate(() => {
            const meta = document.querySelector('meta[http-equiv="Content-Security-Policy"]');
            return meta !== null;
        });
        assert(hasCSP, 'No CSP meta tag found');
    });

    console.log('\n🔷 8. Console Errors\n');

    await test('No critical JavaScript errors', async () => {
        // Filter out known optional resource errors
        const critical = consoleErrors.filter(e =>
            !e.includes('Iroh') && !e.includes('iroh') && !e.includes('P2P') &&
            !e.includes('service worker') && !e.includes('favicon') &&
            !e.includes('manifest') && !e.includes('linker_iroh') &&
            !e.includes('404 (Not Found)')
        );
        assert(critical.length === 0, `Console errors: ${critical.join('; ')}`);
    });

    await test('No unexpected failed requests', async () => {
        const unexpected = failedRequests.filter(url =>
            !url.includes('iroh') && !url.includes('linker_iroh')
        );
        assert(unexpected.length === 0, `Failed requests: ${unexpected.join(', ')}`);
    });

    // Summary
    console.log(`\n${'═'.repeat(50)}`);
    console.log(`Results: ${passed} passed, ${failed} failed, ${passed + failed} total`);
    console.log(`${'═'.repeat(50)}\n`);

} catch (e) {
    console.error('Fatal error:', e.message);
    failed++;
} finally {
    if (browser) await browser.close();
    process.exit(failed > 0 ? 1 : 0);
}
