# TDD Red-Green-Refactor cycle
# 1. Red: Write failing test
cat > test/calculator.test.js << 'EOF'
const { expect } = require('chai');
const Calculator = require('../src/Calculator');

describe('Calculator', function() {
  it('should add two numbers', function() {
    const calc = new Calculator();
    expect(calc.add(2, 3)).to.equal(5);
  });
});
EOF

# 2. Run test (should fail)
npx mocha test/calculator.test.js

# 3. Green: Write minimal code to pass
mkdir -p src
cat > src/Calculator.js << 'EOF'
class Calculator {
  add(a, b) {
    return a + b;
  }
}

module.exports = Calculator;
EOF

# 4. Run test (should pass)
npx mocha test/calculator.test.js

# 5. Refactor: Improve code quality
# 6. Repeat cycle