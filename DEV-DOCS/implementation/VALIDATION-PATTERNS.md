# Implementation Patterns: Validation

## API Validation Rules
- validate required parameters immediately
- fail fast with clear `400` response for client mistakes
- return `401` for auth failures and `503` for dependency unavailability

## Filesystem Validation Rules
- normalize and resolve paths before access
- block traversal beyond workspace root
- gracefully handle missing files/directories

## Gateway Validation Rules
- verify gateway connectivity before mutation operations
- keep fallback behavior explicit (HTTP, WS, docker fallback)
- surface degraded mode through response and logs

## Test Validation Rules
- include happy path and unauthorized path checks
- capture response shape expectations in tests
