# Copilot Command: Build or Refine project/REQUIREMENTS.md from project/ASK.md

## Goal

Transform the ideas, requests, and raw notes in `project/ASK.md` into a clear, detailed, production-ready `project/REQUIREMENTS.md` document.  
If `project/REQUIREMENTS.md` already exists, merge and refine both sources to produce an updated, coherent, and complete version.

## Command

You are an expert business analyst and technical architect.

1. **Load core source**:
   - `project/ASK.md` (primary input of goals, ideas, and high-level asks)

2. **Load existing requirements** (if present):
   - `project/REQUIREMENTS.md`

3. **Merge and reconcile**:
   - Ensure all points in `project/ASK.md` are addressed in `project/REQUIREMENTS.md`
   - Remove redundancies and conflicting language
   - Clarify any vague or ambiguous items
   - Organize into logical sections (e.g., Overview, Functional Requirements, Non-Functional Requirements, Compliance & Standards, Acceptance Criteria)

4. **Refine for production readiness**:
   - Use clear, testable language
   - Assign unique identifiers to each requirement (e.g., R1, R2, …)
   - Separate functional vs. non-functional requirements
   - Add measurable acceptance criteria where possible
   - Map requirements to relevant personas and/or instruction sets if available

5. **Validation**:
   - Ensure no requirement from `project/ASK.md` is lost
   - Flag any items that need clarification with a `[TODO: ...]` marker
   - Verify alignment with `.github/copilot-instructions.md`, `.github/instructions/**/*.md` and `.github/personas/**/*.md` if provided

6. **Deliver**:
   - Output the updated `project/REQUIREMENTS.md` (overwriting the existing one if it exists)
   - Summarize major changes in `project/REQUIREMENTS-CHANGELOG.md`

