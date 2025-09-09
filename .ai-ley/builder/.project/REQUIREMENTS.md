
# Agent System Prompt — Node-RED-style .ai-ley Builder + PlantUML Flows

**Mission:**  
Upgrade the **.ai-ley builder** to a visual, Node-RED-style editor. Provide a palette of node types (prompts, logic, outputs, loops, custom text, personas, instructions). Allow users to drag nodes onto a canvas, wire nodes **left→right**, support **1:many** and **many:1** connections, organize multiple **flows as tabs**, and export each tab to a **PlantUML** artifact under a configurable path (default: `.ai-ley/shared/uml-flows/user`).

---

## Operating Constraints
- **Non-destructive**: add functionality without breaking existing .ai-ley behaviors.
- **Deterministic**: no placeholder text beyond what is strictly necessary; state any assumption explicitly.
- **Portable**: do not require cloud services to render flows; everything runs locally in the repo.
- **Style**: visual affordances should feel **Node-RED-like** (left input handle, right output handle; tidy orthogonal edges; compact cards).
- **Accessibility**: keyboard navigation for node selection/movement; focus outlines; ARIA labels for palette items.
- **Config**: default PlantUML export path is `.ai-ley/shared/uml-flows/user`, overridable via `.ai-ley/config.json` → `uml.exportPath`.

---

## Deliverables
1. **Visual Flow Editor**
   - **Palette** (left dock):  
     - `CommandPromptFile`, `LogicCondition`, `OutputType`, `Loop`, `CustomPromptText`, `Persona`, `Instruction`.
   - **Canvas**: drag from palette; nodes render with **input port(s) on the left**, **output port(s) on the right**.
   - **Connections**: support **1:many** fan-out and **many:1** fan-in. Prevent cycles unless passing through a `Loop`.
   - **Tabs**: each **flow** is a tab. Tabs can be added/renamed/duplicated/deleted.
   - **Inspector panel** (right dock): editable properties per node; live validation; link to source artifacts (e.g., command prompt file path).
   - **Mini-map**, **zoom**, **snap-to-grid**.

2. **Serialization & Export**
   - **JSON flow schema** (see “Flow JSON Schema”) stored in `.ai-ley/shared/flows/*.json`.
   - **PlantUML exporter**: one `.puml` per tab under `.ai-ley/shared/uml-flows/user/<flow-name>.puml` (configurable).
   - CLI: `ai-ley flows export` → regenerates all `.puml` from JSON flows.

3. **Validation & Rules Engine**
   - Type-aware wiring (see “Wiring Rules”).
   - Lint: orphan nodes, dangling edges, unreachable sinks, missing required fields, potential cycles (unless `Loop` node).
   - Quick-fix suggestions in Inspector.

4. **Tests & Docs**
   - Unit tests for serializers, validators, exporter; e2e test for add-node→wire→export.
   - `README` updates with screenshots/gifs, keyboard shortcuts, and CLI usage.

---

## Node Types & Properties

### 1) `CommandPromptFile` (file-backed)
- **Props:** `path` (string, required), `inputs` (record), `outputs` (record), `label` (string)
- **Semantics:** references a reusable prompt file; produces typed outputs.
- **Ports:** 1 input (optional), 1..n outputs (configurable).

### 2) `LogicCondition`
- **Props:** `expression` (JS-like boolean or DSL), `cases` (array `{label, when}`), `defaultCase` (optional)
- **Ports:** 1 input, 1..n outputs (one per case + default)

### 3) `OutputType`
- **Props:** `format` (one of: `markdown|json|plantuml|csv|html|text|custom`), `destination` (file path or sink id)
- **Ports:** 1..n inputs, 0..1 output (usually terminal)

### 4) `Loop`
- **Props:** `iterableExpr` (string), `maxIterations` (int), `breakCondition` (expr)
- **Ports:** 1 input (seed), 1 output (body), 1 optional output (`onComplete`)
- **Semantics:** allows a sanctioned cycle; validator must not flag loop edges as errors.

### 5) `CustomPromptText`
- **Props:** `template` (multiline string, supports variables), `variables` (record)
- **Ports:** 0..1 input (data binding), 1 output (rendered prompt)

### 6) `Persona`
- **Props:** `id` or `path`, `traits` (optional), `overrideTone` (optional)
- **Ports:** 1 input (upstream data), 1 output (persona-contextualized prompt)

### 7) `Instruction`
- **Props:** `id` or `path`, `priority` (int), `mode` (`strict|advisory`)
- **Ports:** 1 input, 1 output

---

## Wiring Rules (enforced at connect-time)
- **Direction:** strictly **left→right**.
- **Cardinality:** allow **1:many** and **many:1**. Disallow many:many at a single port; use join/fork patterns (implicit via multiple edges).
- **Type compatibility:**  
  - `CustomPromptText` → `Persona|Instruction|CommandPromptFile`.  
  - `Persona|Instruction` → `CommandPromptFile|LogicCondition|OutputType`.  
  - `LogicCondition` branches → any downstream compatible node(s).  
  - `CommandPromptFile` outputs → `LogicCondition|OutputType|Loop`.  
  - `Loop` body → any node; closing edge may return to pre-loop node (marked as loopback).  
  - `OutputType` typically terminal (no downstream), unless piping to another sink node.
- **No illegal cycles**: only edges marked **loopback** exiting a `Loop` may create a cycle.

---

## Flow JSON Schema (authoritative)
```json
{
  "version": "1.0.0",
  "name": "string",
  "nodes": [
    {
      "id": "node-uuid",
      "type": "CommandPromptFile|LogicCondition|OutputType|Loop|CustomPromptText|Persona|Instruction",
      "label": "string",
      "position": {"x": 0, "y": 0},
      "props": {},
      "ports": {
        "in": [{"id":"pin","label":"in","type":"any"}],
        "out": [{"id":"pout","label":"out","type":"any"}]
      },
      "meta": {"icon":"string","color":"#hex"}
    }
  ],
  "edges": [
    {
      "id": "edge-uuid",
      "from": {"nodeId":"node-uuid","portId":"pout"},
      "to": {"nodeId":"node-uuid","portId":"pin"},
      "kind": "normal|loopback",
      "label": "string"
    }
  ]
}
```

---

## PlantUML Export (spec)

- **File path (default):** `.ai-ley/shared/uml-flows/user/<flow-name>.puml`
- **Template mapping:**
  - Each **node** → `rectangle "<label>\n<<type>>" as N<ID>` with a stereotype matching `type`.
  - Each **edge** → `N<from> --> N<to> : <label>`; use `..>` for loopbacks and append `<<loop>>`.
  - Group tabs in separate files; each file contains a single flow.

**Example export:**
```plantuml
@startuml
title Flow: Onboard User
skinparam rectangle {
  BackgroundColor<<Loop>> #eef7ff
  BackgroundColor<<LogicCondition>> #fff7e6
}
rectangle "Persona: BlaineAI
<<Persona>>" as N1
rectangle "Welcome Template
<<CustomPromptText>>" as N2
rectangle "Select Path
<<LogicCondition>>" as N3
rectangle "Onboard Cmd
<<CommandPromptFile>>" as N4
rectangle "Save as Markdown
<<OutputType>>" as N5
N1 --> N2 : apply persona
N2 --> N3 : render
N3 --> N4 : when isNew
N4 --> N5 : write file
@enduml
```

---

## UI/UX Requirements
- **Palette**: searchable; drag start announces node name; drop snaps to grid.
- **Canvas**: orthogonal connectors; hover highlights valid targets; connection preview shows type compatibility.
- **Inspector**: focus-first on required fields; inline validation messages; link out to backing files.
- **Tabs**: `+` to add; right-click → duplicate/export/rename/delete; unsaved indicator.
- **Shortcuts**: `Del` delete, `Cmd/Ctrl+D` duplicate node, `Cmd/Ctrl+E` export, `Cmd/Ctrl+S` save flow JSON.

---

## Implementation Hints (non-binding)
- **Frontend**: React with a graph editor (e.g., React Flow) for ports/edges; CSS variables for theming.
- **State**: serialize to **Flow JSON Schema** on save; derive PlantUML via a pure function `toPlantUml(flowJson)`.
- **Persistence**: write flow JSON under `.ai-ley/shared/flows/`; ensure idempotent export.
- **CLI**: `ai-ley flows export [--out <path>] [--flow <name>]`.

---

## Validation & Quality Gate (must pass)
- ✅ Can create each node type from palette, edit props, wire valid edges, and **prevent invalid** ones.
- ✅ Supports **1:many** and **many:1** connections; loopback only via `Loop`.
- ✅ Save/Load round-trip: JSON → UI → JSON is stable (no id churn).
- ✅ Export produces a valid **PlantUML** file per tab at the configured path.
- ✅ Lints report: orphan nodes, dangling edges, unreachable sinks, missing props.
- ✅ Keyboard accessibility works for palette and canvas selection.
- ✅ Docs & tests included (unit for serializer/validator; e2e: create→wire→export).

---

## Step-by-Step Plan (agent execution)
1. **Scaffold UI**: palette + canvas + inspector + tabs; wire basic drag-drop.
2. **Define schema** and implement (de)serialization with stable IDs.
3. **Implement nodes** with default ports; add node-specific property editors.
4. **Enforce wiring rules** (types, cardinality, loopback).
5. **Add lints & quick-fixes**; show badges on tabs for issues.
6. **Implement PlantUML exporter**; map JSON → `.puml`.
7. **Persist config** (`uml.exportPath`, default `.ai-ley/shared/uml-flows/user`).
8. **Add tests & docs**; record demonstration gifs.
9. **Finalize**: pass **Quality Gate** and ship.

---

## Assumptions
- React is the builder’s UI framework; Node/TS available for CLI.
- File system writes are permitted under `.ai-ley/shared/**`.
- PlantUML artifacts are consumed elsewhere; PNG/SVG rendering is **out-of-scope** for this task.
