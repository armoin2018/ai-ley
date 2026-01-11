---
name: 'Template Flow Name'
description: 'Brief description of this workflow and when to use it'
keywords: [workflow, flow, automation, process]
---

# Flow Name

## Overview

**Purpose:** What this flow accomplishes

**Trigger:** When/how this flow is initiated

**Duration:** Estimated time to complete

**Participants:**

- Role/Agent 1
- Role/Agent 2
- Role/Agent 3

## Prerequisites

**Required Inputs:**

- [ ] Input 1: Description and location
- [ ] Input 2: Description and location
- [ ] Input 3: Description and location

**Required Resources:**

- [ ] Resource 1: What is needed
- [ ] Resource 2: What is needed
- [ ] Resource 3: What is needed

**System State:**

- [ ] State requirement 1
- [ ] State requirement 2
- [ ] State requirement 3

## Flow Diagram

```plantuml
@startuml
!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Container.puml

title Flow Name

actor User
participant "Agent 1" as A1
participant "Agent 2" as A2
database "Data Store" as DB

User -> A1: Initiate flow
activate A1

A1 -> A1: Process input
A1 -> DB: Read data
activate DB
DB --> A1: Return data
deactivate DB

A1 -> A2: Delegate task
activate A2
A2 -> A2: Execute task
A2 --> A1: Return result
deactivate A2

A1 --> User: Provide output
deactivate A1

@enduml
```

## Steps

### Step 1: [Step Name]

**Agent:** [Agent name from .github/agents/]

**Prompt:** [Prompt name from .github/prompts/]

**Instructions:**

- Instruction 1
- Instruction 2
- Instruction 3

**Inputs:**

- Input file/data 1: `{{files.input1}}`
- Input file/data 2: `{{files.input2}}`

**Outputs:**

- Output file/data 1: `{{files.output1}}`
- Output file/data 2: `{{files.output2}}`

**Success Criteria:**

- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

### Step 2: [Step Name]

**Agent:** [Agent name from .github/agents/]

**Prompt:** [Prompt name from .github/prompts/]

**Instructions:**

- Instruction 1
- Instruction 2
- Instruction 3

**Inputs:**

- Input from Step 1: `{{files.output1}}`
- Additional input: `{{files.input3}}`

**Outputs:**

- Final output: `{{files.final-output}}`

**Success Criteria:**

- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

### Step 3: [Validation Step]

**Agent:** ailey-orchestrator

**Purpose:** Validate all outputs and ensure quality

**Validation Checklist:**

- [ ] Output 1 meets requirements
- [ ] Output 2 meets requirements
- [ ] All success criteria from previous steps met
- [ ] No errors or warnings
- [ ] Ready for handoff

## Decision Points

### Decision 1: [Decision Name]

**Condition:** When to make this decision

**Options:**

1. **Option A**: When condition X is true
   - Action: Proceed to Step Y
   - Impact: Description
2. **Option B**: When condition X is false
   - Action: Proceed to Step Z
   - Impact: Description

### Decision 2: [Decision Name]

**Condition:** When to make this decision

**Options:**

1. **Option A**: Description
   - Action: Next step
   - Impact: Description
2. **Option B**: Description
   - Action: Alternative step
   - Impact: Description

## Error Handling

### Error Type 1

**Detection:** How to identify this error

**Recovery:**

1. Recovery step 1
2. Recovery step 2
3. Recovery step 3

**Escalation:** When to escalate and to whom

### Error Type 2

**Detection:** How to identify this error

**Recovery:**

1. Recovery step 1
2. Recovery step 2
3. Recovery step 3

**Escalation:** When to escalate and to whom

## Outputs

**Primary Deliverables:**

- Deliverable 1: `{{files.deliverable1}}` - Description
- Deliverable 2: `{{files.deliverable2}}` - Description
- Deliverable 3: `{{files.deliverable3}}` - Description

**Metadata:**

- Execution log: `{{folders.project}}/flow-execution-[timestamp].log`
- Metrics: Response time, resource usage, quality scores
- Status: Success/Failure with details

## Quality Assurance

**Automated Checks:**

- [ ] Check 1: Description
- [ ] Check 2: Description
- [ ] Check 3: Description

**Manual Reviews:**

- [ ] Review 1: Who reviews what
- [ ] Review 2: Who reviews what
- [ ] Review 3: Who reviews what

**Acceptance Criteria:**

- [ ] All steps completed successfully
- [ ] All outputs validated
- [ ] Quality standards met
- [ ] Documentation updated

## Monitoring & Metrics

**Key Metrics:**

- Metric 1: Definition and target
- Metric 2: Definition and target
- Metric 3: Definition and target

**Tracking:**

- Where metrics are stored
- How often they are reviewed
- Who is responsible for monitoring

## Related Flows

**Upstream Flows:**

- Flow 1: `.github/ai-ley/flows/[category]/[flow-name].md`
- Flow 2: `.github/ai-ley/flows/[category]/[flow-name].md`

**Downstream Flows:**

- Flow 1: `.github/ai-ley/flows/[category]/[flow-name].md`
- Flow 2: `.github/ai-ley/flows/[category]/[flow-name].md`

**Alternative Flows:**

- Alternative 1: When to use instead
- Alternative 2: When to use instead

## References

**Prompts:**

- `.github/prompts/ailey-[prompt-name].prompt.md`
- `.github/prompts/ailey-[prompt-name].prompt.md`

**Agents:**

- `.github/agents/ailey-[agent-name].agent.md`
- `.github/agents/ailey-[agent-name].agent.md`

**Instructions:**

- `.github/ai-ley/instructions/[category]/[name].md`
- `.github/ai-ley/instructions/[category]/[name].md`

**Personas:**

- `.github/ai-ley/personas/[domain]/[name].md`
- `.github/ai-ley/personas/[domain]/[name].md`

## Notes

- Important note 1
- Important note 2
- Important note 3

---

version: 1.0.0
updated: 2026-01-11
reviewed: 2026-01-11
score: 4.0
