# Lessons Learned

## 1) Duplicate blocks are expensive
`dashboard.py` currently includes duplicated helper/runtime regions. Even when behavior still works, this creates silent drift and review risk.

## 2) Token source precedence must be deterministic
Test and runtime reliability depends on consistent token source resolution. Mixed environment vs persisted config sources can produce false failures.

## 3) Global state coupling complicates startup
Auth/config state currently depends on runtime globals and startup order. Changes in one area can affect unrelated endpoints.

## 4) Evidence-first audits improve remediation
Command exports in `DEV-DOCS/reports/` made findings concrete and prioritized.

## 5) Comment quality matters in single-file architecture
Complex fallback and parsing logic needs intent comments to keep maintenance velocity safe.
