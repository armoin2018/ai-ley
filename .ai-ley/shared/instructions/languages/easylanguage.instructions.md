# EasyLanguage — AI Assistant Guidelines (TradeStation/MultiCharts)

Purpose: Author and evaluate trading strategies/indicators within broker/platform environments while preventing lookahead and ensuring reproducibility.

## When to use
- You must deploy logic directly inside TradeStation/MultiCharts with native backtesting/execution.

## When to avoid
- Cross-broker portability or advanced data engineering needed (use Python/Lean/Zipline externally).

## Core rules
- No lookahead: reference only completed bars; use BarStatus checks and avoid Intrabarpersist pitfalls.
- Session awareness: adhere to exchange sessions and roll logic; handle PIT/roll for futures.
- Params: expose inputs with defaults; document all optimizable parameters.

## Backtesting hygiene
- Use realistic order fill assumptions and slippage/commission.
- Warmup periods: ignore performance during warmup bars; don’t forward-fill.
- Out-of-sample: reserve unseen segments or use walk-forward optimizer.

## Risk controls
- Fixed fractional sizing caps; daily loss halts; max positions per symbol/global.
- Protective orders: stop loss, profit target, trailing; cancel/replace logic validated.

## Testing
- Deterministic results with fixed data and platform version pinning.
- Golden strategy tests for canonical entries/exits; assert positions/PNL per bar.

## AI Assistant rules
- Generate strategies with comments on assumptions and parameter ranges.
- Provide import/export steps for the platform and a checklist for going live.
