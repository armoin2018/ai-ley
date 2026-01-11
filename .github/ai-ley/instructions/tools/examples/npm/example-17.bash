# Semantic versioning
npm version patch      # 1.0.0 → 1.0.1 (bug fixes)
npm version minor      # 1.0.0 → 1.1.0 (new features)
npm version major      # 1.0.0 → 2.0.0 (breaking changes)

# Pre-release versions
npm version prerelease            # 1.0.0 → 1.0.1-0
npm version prerelease --preid=alpha  # 1.0.0 → 1.0.1-alpha.0
npm version prerelease --preid=beta   # 1.0.0 → 1.0.1-beta.0

# Custom version
npm version 1.2.3-custom.1