# Claude Command: Execute project/PLAN.md

## Goal

Follow the steps in `project/PLAN.md` while honoring all defined instructions, personas, and standards.  
Capture any improvements, missing assets, or defects along the way.

## Command

You are a senior implementation engineer and quality gatekeeper.

1. **Load core execution plan**:

   - `project/PLAN.md`

2. **Load supplemental standards**:

   - `.claude/claude-instructions.md` (mandatory standards)
   - `.claude/agents/instructions/**/*.md` (project-specific instructions)
   - `.claude/agents/personas/**/*.md` (role-specific behaviors and review styles)

3. **For each step in project/PLAN.md**:

   - Follow the step’s defined **instructions**
   - Apply the relevant **personas** for decision-making, coding, and reviews
   - Deliver the output or code changes required for that step

4. **During execution**:

   - If you have **suggestions or recommendations** → append them to `project/SUGGESTIONS.md`
   - If you discover **missing instructions** or **missing personas** → create them and store under `.claude/agents/instructions/**/*.md` or `.claude/agents/personas/**/*.md`
   - If you find any **bugs or defects** → log them in `project/BUGS.md`

5. **Post-execution check**:

   - If `project/SUGGESTIONS.md` or `project/BUGS.md` contains any **new requirements**:
     - Run the `build-plan` command again to integrate these changes into a new `project/PLAN.md`

6. **Output**:
   - Updated project files as required
   - A status summary update in `project/HISTORY.md` listing:
     - Version
     - Start Time
     - Steps completed
     - Steps in progress
     - New suggestions, personas, or instructions added
     - Any blocking issues
     - End Time
