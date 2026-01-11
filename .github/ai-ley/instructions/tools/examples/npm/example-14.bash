# Prepare for publishing
npm login
npm whoami                         # Verify login

# Publishing workflow
npm version patch                  # Bump version (patch/minor/major)
npm publish                        # Publish to registry
npm publish --access public       # Public scoped package
npm publish --tag beta             # Publish with tag

# Managing published packages
npm deprecate package@1.0.0 "Use version 2.0.0+"
npm unpublish package@1.0.0        # Unpublish (within 24 hours)
npm owner add username package     # Add package maintainer
npm owner remove username package  # Remove maintainer

# Package distribution tags
npm dist-tag add package@1.0.0 stable
npm dist-tag rm package stable
npm dist-tag ls package