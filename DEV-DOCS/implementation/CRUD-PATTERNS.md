# Implementation Patterns: CRUD and Mutations

## Goal
Standardize safe mutation patterns for gateway-backed operations and local state updates.

## Pattern 1: Validate request payload early
- use `request.get_json(silent=True) or {}`
- explicitly require keys and return `400` on missing values

## Pattern 2: Keep mutation endpoints narrow
- each route should handle one mutation type
- avoid hidden side effects not reflected in response

## Pattern 3: Return explicit operation status
- success: `{ "ok": true, ... }`
- failure: `{ "error": "..." }` with clear status code

## Pattern 4: Document gateway dependency
If a mutation relies on `_gw_invoke` or `_gw_ws_rpc`, include comments and error mapping for unavailable gateway states.

## Pattern 5: Add regression tests
Any mutation endpoint change should add or update API test coverage.
