# Essential Turbo commands
turbo build                              # Build all packages
turbo build --filter=@company/web        # Build specific package
turbo build --filter='./apps/*'          # Build all apps
turbo build --filter=[HEAD^1]            # Build changed packages
turbo test --parallel                     # Run tests in parallel
turbo run build --dry-run                # Show what would be executed
turbo run build --graph                  # Show task dependency graph
turbo prune --scope=@company/web          # Create pruned workspace

# Cache management
turbo run build --force                  # Force rebuild (ignore cache)
turbo run build --no-cache               # Disable caching
turbo cache clean                        # Clear local cache
turbo login                              # Login to remote cache
turbo link                               # Link to remote cache

# Performance analysis
turbo run build --profile               # Generate performance profile
turbo run build --summarize             # Show build summary
turbo run build --dry-run=json          # Output build plan as JSON