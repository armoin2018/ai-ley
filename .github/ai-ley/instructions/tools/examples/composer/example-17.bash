# Submit to Packagist
1. Push code to GitHub/GitLab
2. Go to https://packagist.org
3. Click "Submit"
4. Enter repository URL
5. Add webhooks for auto-updates

# Validate before publishing
composer validate --strict
composer check-platform-reqs

# Tag releases
git tag -a v1.0.0 -m "Version 1.0.0"
git push origin v1.0.0