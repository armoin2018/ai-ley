# Example debugging workflow with version control
git log --oneline -10  # Check recent changes
git bisect start
git bisect bad HEAD    # Current state is bad
git bisect good <known-good-commit>  # Last known good state

# Git will checkout commits for testing
# After each test:
git bisect good   # if test passes
git bisect bad    # if test fails

# When done:
git bisect reset