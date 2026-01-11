# Daily development workflow
git checkout main
git pull origin main                    # Get latest changes
git checkout -b feature/new-feature     # Create feature branch
# ... make changes ...
git add .
git commit -m "Implement new feature"
git push -u origin feature/new-feature  # Push feature branch
# ... create pull request ...
# ... after review and approval ...
git checkout main
git pull origin main                    # Update main
git branch -d feature/new-feature      # Clean up local branch