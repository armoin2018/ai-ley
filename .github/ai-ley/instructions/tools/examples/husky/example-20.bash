# .husky/pre-commit - Multi-stage with early exit
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "${YELLOW}🔍 Starting pre-commit validation...${NC}"

# Stage 1: Fast checks first
echo "${YELLOW}📝 Stage 1: Code style and formatting...${NC}"
npx lint-staged || {
  echo "${RED}❌ Code style checks failed${NC}"
  exit 1
}

# Stage 2: Type checking
if [ -f "tsconfig.json" ]; then
  echo "${YELLOW}📘 Stage 2: Type checking...${NC}"
  npm run type-check || {
    echo "${RED}❌ TypeScript type checking failed${NC}"
    exit 1
  }
fi

# Stage 3: Unit tests for changed files
echo "${YELLOW}🧪 Stage 3: Running related tests...${NC}"
npm run test:related || {
  echo "${RED}❌ Related tests failed${NC}"
  exit 1
}

# Stage 4: Security checks
echo "${YELLOW}🔒 Stage 4: Security scanning...${NC}"
npm audit --audit-level high || {
  echo "${YELLOW}⚠️  High-severity security issues found${NC}"
  echo "${YELLOW}Continue with caution or run 'npm audit fix'${NC}"
}

echo "${GREEN}✅ All pre-commit checks passed!${NC}"