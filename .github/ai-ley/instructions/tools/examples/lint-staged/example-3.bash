# Create .git/hooks/pre-commit manually
cat > .git/hooks/pre-commit << 'EOF'
#!/bin/sh
npx lint-staged
EOF

chmod +x .git/hooks/pre-commit

# Alternative: using git config
git config core.hooksPath .githooks
mkdir .githooks
echo "npx lint-staged" > .githooks/pre-commit
chmod +x .githooks/pre-commit