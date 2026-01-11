# Initialize Git repository (if not already done)
git init
git add .
git commit -m "Initial commit"

# Add remote repository (GitHub, GitLab, Bitbucket)
git remote add origin https://github.com/username/your-project.git
git push -u origin main

# Netlify will automatically detect and deploy from Git