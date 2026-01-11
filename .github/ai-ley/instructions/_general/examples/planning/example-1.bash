# Example planning integration with development
git checkout -b planning/epic-user-management
# Create planning documents
mkdir -p docs/planning/epics/user-management
echo "# User Management Epic Planning" > docs/planning/epics/user-management/overview.md
echo "## Work Breakdown" > docs/planning/epics/user-management/wbs.md
echo "## Risk Assessment" > docs/planning/epics/user-management/risks.md

# Link planning to implementation
git commit -m "feat: add user management epic planning

- Defines scope and work breakdown structure
- Identifies technical risks and dependencies
- Provides estimation framework for development

Epic: USER-001"