# Finance and Trading Framework Instructions

## Overview

- **Domain**: Financial Technology and Algorithmic Trading
- **Purpose**: Guide AI agents in implementing financial applications, trading systems, and quantitative analysis
- **Applicable To**: Trading platforms, portfolio management, risk analysis, and financial data processing
- **Complexity Level**: Advanced (requires regulatory compliance and high-performance execution)

## Core Concepts

### Essential Concepts

- **Risk Management First**: Comprehensive risk controls and position sizing before any trading logic
- **Regulatory Compliance**: All implementations must meet relevant financial regulations and standards
- **Data Integrity**: Accurate, timely, and auditable financial data throughout operations
- **Performance Optimization**: Low-latency execution and high-throughput data processing

### Key Benefits

- Reduced operational risk through systematic risk management and compliance frameworks
- Improved trading performance with optimized execution algorithms and robust backtesting
- Enhanced decision-making through comprehensive market data analysis and portfolio optimization
- Increased automation efficiency with systematic portfolio management and rebalancing

## Implementation Guidelines

### Getting Started

```python
# Essential fintech project setup
import pandas as pd
import numpy as np
from typing import Dict, List, Optional
from dataclasses import dataclass
from datetime import datetime
import asyncio

# Risk management and compliance setup
from risk_manager import RiskManager
from compliance import ComplianceMonitor
```

### Core Patterns

```python
# Pattern 1: Trading Order with Risk Validation
@dataclass
class Order:
    symbol: str
    quantity: float
    order_type: str  # 'market', 'limit', 'stop'
    price: Optional[float] = None
    timestamp: datetime = None

class TradingSystem:
    def __init__(self, risk_manager: RiskManager):
        self.risk_manager = risk_manager
        self.positions = {}

    def place_order(self, order: Order) -> bool:
        # Risk validation before execution
        if not self.risk_manager.validate_order(order):
            return False

        # Execute order with audit trail
        return self.execute_order(order)

# Pattern 2: Portfolio Risk Monitoring
class PortfolioMonitor:
    def calculate_var(self, positions: Dict, confidence: float = 0.05) -> float:
        # Value at Risk calculation
        portfolio_values = [pos.market_value for pos in positions.values()]
        portfolio_std = self.calculate_portfolio_volatility(positions)
        return portfolio_std * self.get_var_multiplier(confidence)

    def check_risk_limits(self, portfolio_var: float, max_risk: float) -> bool:
        return portfolio_var <= max_risk

# Pattern 3: Backtesting Framework
class Backtester:
    def __init__(self, initial_capital: float, transaction_cost: float = 0.001):
        self.initial_capital = initial_capital
        self.transaction_cost = transaction_cost

    def run_backtest(self, strategy, market_data: pd.DataFrame):
        # Execute strategy with realistic costs and slippage
        return self.calculate_performance_metrics()
```

### Best Practices

- **Risk Controls**: Position limits, stop-losses, and portfolio risk monitoring with real-time alerts
- **Execution Quality**: Smart order routing, VWAP strategies, and transaction cost analysis
- **Compliance Framework**: Automated audit trails, regulatory reporting, and risk governance

## Common Use Cases

### Use Case 1: Algorithmic Trading Strategy

**When**: Implementing systematic trading strategies with risk management
**Implementation**:

```python
# Complete algorithmic trading system
class MovingAverageCrossover:
    def __init__(self, fast_period: int = 10, slow_period: int = 30):
        self.fast_period = fast_period
        self.slow_period = slow_period

    def generate_signals(self, market_data: pd.DataFrame) -> List[Order]:
        signals = []

        # Calculate moving averages
        market_data['fast_ma'] = market_data['close'].rolling(self.fast_period).mean()
        market_data['slow_ma'] = market_data['close'].rolling(self.slow_period).mean()

        # Generate crossover signals
        if market_data['fast_ma'].iloc[-1] > market_data['slow_ma'].iloc[-1]:
            # Bullish signal
            order = Order(
                symbol=market_data['symbol'].iloc[-1],
                quantity=self.calculate_position_size(market_data),
                order_type='market',
                timestamp=datetime.now()
            )
            signals.append(order)

        return signals
```

### Use Case 2: Portfolio Optimization

**When**: Automated portfolio rebalancing with risk-adjusted optimization
**Implementation**:

```python
# Portfolio optimization with mean-variance
from scipy.optimize import minimize

class PortfolioOptimizer:
    def optimize_weights(self, expected_returns: np.ndarray,
                        cov_matrix: np.ndarray) -> Dict:
        n_assets = len(expected_returns)

        # Maximize Sharpe ratio
        def objective(weights):
            portfolio_return = np.sum(weights * expected_returns)
            portfolio_risk = np.sqrt(np.dot(weights.T, np.dot(cov_matrix, weights)))
            return -(portfolio_return / portfolio_risk)  # Negative for minimization

        # Constraints: weights sum to 1
        constraints = [{'type': 'eq', 'fun': lambda x: np.sum(x) - 1}]
        bounds = [(0, 1)] * n_assets

        result = minimize(objective, [1/n_assets] * n_assets,
                         constraints=constraints, bounds=bounds)

        return {'weights': result.x, 'success': result.success}
```

### Use Case 3: Risk Management System

**When**: Real-time portfolio risk monitoring and position sizing
**Implementation**:

```python
# Advanced risk management
class RiskManager:
    def __init__(self, max_portfolio_risk: float = 0.02):
        self.max_portfolio_risk = max_portfolio_risk

    def calculate_position_size(self, entry_price: float, stop_loss: float,
                              portfolio_value: float, volatility: float) -> float:
        # Risk per share
        risk_per_share = abs(entry_price - stop_loss)

        # Maximum dollar risk (1% of portfolio)
        max_risk = portfolio_value * 0.01

        # Position size based on volatility adjustment
        volatility_factor = min(volatility, 0.05) / 0.02  # Normalize to 2% baseline
        adjusted_risk = max_risk / max(volatility_factor, 0.5)

        return adjusted_risk / risk_per_share

    def monitor_drawdown(self, equity_curve: pd.Series) -> Dict:
        # Calculate maximum drawdown
        peak = equity_curve.cummax()
        drawdown = (equity_curve - peak) / peak
        max_drawdown = drawdown.min()

        return {
            'current_drawdown': drawdown.iloc[-1],
            'max_drawdown': max_drawdown,
            'alert': abs(max_drawdown) > 0.1  # 10% drawdown alert
        }
```

## Anti-Patterns to Avoid

- **Overfitting**: Creating strategies that work on historical data but fail in live markets
- **Ignoring Costs**: Developing strategies without realistic transaction costs and slippage
- **Poor Risk Management**: Trading without proper position sizing and risk controls
- **Compliance Gaps**: Implementing systems without regulatory compliance considerations

## Integration & Tools

### Essential Tools

- **Market Data**: Bloomberg API, Interactive Brokers, Alpha Vantage, Quandl for data feeds
- **Execution**: Trading APIs with smart order routing and execution quality monitoring
- **Analytics**: QuantLib for pricing, PyFolio for performance analysis, TA-Lib for indicators
- **Risk Management**: Real-time portfolio monitoring, VaR calculation, and stress testing

### Trading System Architecture

```python
# Production trading system structure
class TradingPlatform:
    def __init__(self):
        self.data_manager = MarketDataManager()
        self.risk_manager = RiskManager()
        self.execution_engine = ExecutionEngine()
        self.compliance_monitor = ComplianceMonitor()
        self.portfolio_tracker = PortfolioTracker()

    async def run_trading_session(self):
        # Initialize market data feeds
        await self.data_manager.connect_feeds()

        # Start risk monitoring
        self.risk_manager.start_monitoring()

        # Execute trading strategies
        while self.is_market_open():
            # Process market data
            market_data = await self.data_manager.get_latest_data()

            # Generate trading signals
            signals = self.strategy.generate_signals(market_data)

            # Validate and execute orders
            for signal in signals:
                if self.risk_manager.validate_order(signal):
                    await self.execution_engine.place_order(signal)

            # Update portfolio and check compliance
            self.portfolio_tracker.update_positions()
            self.compliance_monitor.check_regulations()
```

## AI Assistant Guidelines

When helping with Finance and Trading development:

1. **Risk First**: Always implement comprehensive risk management before any trading logic
2. **Compliance Awareness**: Consider regulatory requirements for all financial implementations
3. **Realistic Testing**: Include transaction costs, slippage, and market impact in backtesting
4. **Data Quality**: Emphasize validation and quality checks for financial data feeds
5. **Security Focus**: Implement secure handling of sensitive financial data and credentials
6. **Performance Monitoring**: Include real-time monitoring and alerting in all systems
7. **Audit Trails**: Maintain comprehensive logging for compliance and debugging
8. **Defensive Programming**: Implement robust error handling and graceful degradation

### Code Generation Rules

- Generate code with comprehensive risk management and position sizing algorithms
- Include realistic transaction costs and execution assumptions in all backtesting
- Implement proper error handling and audit trails for regulatory compliance
- Create modular, testable components with clear separation of concerns
- Include performance monitoring, alerting, and real-time risk management
- Generate secure, production-ready code with proper credential management

### Quality Enforcement

- ✅ Enforce comprehensive risk management in all trading implementations
- ✅ Require realistic backtesting with transaction costs and market impact
- ✅ Block strategies without proper out-of-sample validation and paper trading
- ✅ Promote secure coding practices for financial data handling
- ✅ Require audit trails and comprehensive logging for compliance
- ✅ Enforce regulatory compliance considerations in system design
- 🚫 Block overfitted strategies without robust validation
- 🚫 Avoid implementations without proper risk controls and position sizing
- 🚫 Reject systems without compliance and regulatory considerations

## Resources

- **Quantitative Trading**: "Algorithmic Trading" by Ernest Chan
- **Risk Management**: "Value at Risk" by Philippe Jorion
- **Portfolio Theory**: "Active Portfolio Management" by Grinold and Kahn
