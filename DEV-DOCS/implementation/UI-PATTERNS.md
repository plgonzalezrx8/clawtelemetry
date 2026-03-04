# Implementation Patterns: Embedded UI

## Goal
Keep embedded HTML/CSS/JS maintainable inside `dashboard.py`.

## Pattern 1: Single source for tab behavior
- avoid duplicate tab-state functions
- keep fetch/update intervals centralized

## Pattern 2: Defensive fetch handling
- display empty/error states when API fails
- avoid hard crashes in browser on undefined data

## Pattern 3: Stable IDs/selectors
- keep page and tab IDs stable for Playwright tests
- if selectors change, update e2e tests in same change

## Pattern 4: Avoid duplicated script blocks
- duplicate template sections can silently diverge behavior
- dedupe on function name collisions and repeated HTML constants

## Pattern 5: Keep startup/auth flow explicit
- boot overlays and auth checks should have deterministic order
