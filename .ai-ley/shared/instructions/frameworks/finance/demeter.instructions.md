# Demeter — AI Assistant Guidelines (DeFi/AMM Strategy Framework)

Purpose: Research and simulate AMM/liquidity strategies with price/fee modeling, impermanent loss analysis, and on-chain data hygiene.

## When to use
- Studying Uniswap-like AMMs, concentrated liquidity, and LP optimization.

## Data rules
- On-chain data integrity checks; handle reorgs; normalize timestamps; decode events precisely.
- Fee and price sources documented; stablecoin depegs and oracle lags modeled.

## Simulation
- Slippage from pool depth; tick spacing and fee tiers; position rebalancing costs.
- Gas modeling; MEV considerations; sandwich protection assumptions stated.

## Testing
- Deterministic replays of historical pools with known outcomes; assert fees/IL within tolerance.
- Stress tests on volatile days; scenario analyses.

## AI Assistant rules
- Provide config templates with risk caps; never include private keys.
- Generate a report artifact covering IL, APR, fee APY, and sensitivity.
