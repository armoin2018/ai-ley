# JavaScript Style Guide (Airbnb-based)

This guide codifies how we write modern JavaScript. It’s based on the Airbnb JavaScript Style Guide, adapted with pragmatic defaults and a few project-specific overrides. Follow this guide for all JavaScript in browser and Node contexts.

Use this with automated tooling (ESLint + Prettier) to enforce consistency.

## Scope and goals

- ES2021+ JavaScript, modules-first (ESM) where possible.
- Works for browser (with bundlers) and Node (type: module preferred).
- Enforced via ESLint (airbnb-base) and Prettier (formatting only).
- Clear, maintainable, testable code with strong defaults.

## Rule precedence

1) Security and correctness
2) Readability
3) Performance
4) Personal preference

When rules conflict, follow ESLint config; open a PR to refine rules rather than ad-hoc overrides.

## Tooling setup

Install dev dependencies (choose one package manager):

```sh
# npm
npm i -D eslint eslint-config-airbnb-base eslint-plugin-import \
	prettier eslint-config-prettier eslint-plugin-prettier

# yarn
yarn add -D eslint eslint-config-airbnb-base eslint-plugin-import \
	prettier eslint-config-prettier eslint-plugin-prettier

# pnpm
pnpm add -D eslint eslint-config-airbnb-base eslint-plugin-import \
	prettier eslint-config-prettier eslint-plugin-prettier
```

Example .eslintrc.js:

```js
/** @type {import('eslint').Linter.Config} */
module.exports = {
	root: true,
	env: {
		es2021: true,
		browser: true,
		node: true,
		jest: true,
	},
	parserOptions: { ecmaVersion: 'latest', sourceType: 'module' },
	extends: ['airbnb-base', 'plugin:prettier/recommended'],
	plugins: ['import'],
	rules: {
		// Airbnb-aligned, with practical tweaks
		'no-console': ['warn', { allow: ['warn', 'error'] }],
		'no-plusplus': ['error', { allowForLoopAfterthoughts: true }],
		'arrow-parens': ['error', 'as-needed'],
		'prefer-const': 'error',
		'no-var': 'error',
		'no-param-reassign': ['error', { props: false }],
		'import/order': [
			'error',
			{
				groups: [['builtin', 'external', 'internal'], ['parent', 'sibling', 'index']],
				'newlines-between': 'always',
				alphabetize: { order: 'asc', caseInsensitive: true },
			},
		],
	},
	overrides: [
		{
			files: ['**/*.test.*', '**/*.spec.*'],
			env: { jest: true, node: true },
		},
	],
};
```

Example .prettierrc.json:

```json
{
	"$schema": "https://json.schemastore.org/prettierrc",
	"printWidth": 100,
	"tabWidth": 2,
	"singleQuote": true,
	"semi": true,
	"trailingComma": "all",
	"arrowParens": "always"
}
```

Optional .editorconfig:

```ini
root = true

[*]
indent_style = space
indent_size = 2
end_of_line = lf
charset = utf-8
trim_trailing_whitespace = true
insert_final_newline = true
```

## Language and syntax

- Always use strict mode implicitly via modules; avoid 'use strict' banners.
- Prefer ES modules: `import` / `export`. Avoid CommonJS in new code.
- Use `const` for values that don’t change; `let` otherwise; never `var`.
- Prefer expression transparency and immutability; avoid side effects when practical.
- Prefer `===`/`!==`; avoid `==`/`!=`.
- Use optional chaining `obj?.prop` and nullish coalescing `value ?? fallback`.
- Prefer template literals for string interpolation and multi-line strings.
- Prefer destructuring for objects/arrays; use default values in destructures.
- Avoid implicit type coercion; be explicit with `Number()`, `String()`, `Boolean()`.

## Modules and imports

- One module responsibility per file; keep files focused and small.
- Put all `import` statements at the top; group and alphabetize via `import/order`.
- Prefer named exports over default exports for clarity and tooling.
- Avoid wildcard (`*`) imports; import only what you need.
- Don’t mutate imported bindings; treat imports as read-only.

## Variables and naming

- camelCase for variables/functions; PascalCase for classes/components.
- Boolean names start with `is`, `has`, `can`, `should` (e.g., `isOpen`).
- Avoid abbreviations; be descriptive and concise.
- Don’t use leading underscores for “privacy”; use `#private` fields in classes instead.

## Objects

- Use literal notation: `{}` instead of `new Object()`.
- Use property and method shorthand: `{ x, y, method() { … } }`.
- Use computed property names when dynamic keys are needed: `{ [key]: value }`.
- Prefer object rest/spread over `Object.assign`.
- Do not mutate function parameters; copy first (`{ ...obj }`).

## Arrays

- Use literal notation: `[]` instead of `new Array()`.
- Prefer array methods (`map`, `filter`, `reduce`, `some`, `every`) over manual loops.
- Use spread `...arr` and `Array.from()` for copying/array-like conversion.
- Push with `arr.push(item)`; don’t use `arr[arr.length] = item`.

## Strings

- Single quotes for strings; backticks for interpolation.
- Avoid concatenation with `+`; prefer template literals.
- Build multi-line strings with template literals.

## Numbers and math

- Always pass a radix to `parseInt(str, 10)`; prefer `Number()` when possible.
- Use `Number.isNaN` and `Number.isFinite`.
- Use the exponentiation operator: `x ** y`.

## Functions

- Prefer function declarations for named, shared functions.
- Use arrow functions for callbacks and small anonymous functions.
- Don’t use `arguments`; use rest parameters `(...args)`.
- Put default parameters last.
- Avoid binding in render/loop hot paths; pre-bind or use arrow functions where appropriate.

## Classes and OOP

- Use `class`/`extends`; avoid direct prototype manipulation.
- Use public fields and `#private` fields when needed.
- Methods should avoid arrow syntax; define them as standard methods for proper prototypes.
- Return `this` from mutator methods to support chaining when it improves readability.

## Error handling and logging

- Prefer `try/catch/finally` around `await` calls that can throw.
- Re-throw with context; avoid swallowing errors.
- Use `console.error`/`console.warn` for diagnostics; don’t leave excessive `console.log` in production.

## Async and promises

- Prefer `async`/`await` over raw promise chains.
- Always handle rejections: `try/catch` or `.catch()`.
- Don’t nest promises; return them.
- Use `Promise.all` for independent work, `Promise.allSettled` for best-effort batches.

## Control flow

- Always use braces for blocks, even for single-line statements.
- Prefer early returns to reduce nesting; avoid deep `if/else` pyramids.
- Avoid `switch`; prefer object maps or functions (dispatch tables).

## Iteration

- Prefer array iteration methods; if you need loops, use `for … of` with iterables.
- Avoid `for … in` on arrays and objects unless you check `hasOwnProperty`.
- Avoid `++`/`--` (use `+= 1`/`-= 1`); allowed in `for` afterthoughts.

## DOM and browser code

- Keep DOM manipulation minimal; batch updates to reduce reflows.
- Cache selectors (`const el = document.querySelector('#id')`).
- Use event delegation for dynamic content (`parent.addEventListener('click', handler)`).
- Sanitize any HTML you inject; prefer `textContent` over `innerHTML`.

## jQuery (if used)

- No inline JS in HTML; all scripts live in dedicated files.
- Cache jQuery selections: `const $el = $('#id')`; reuse them.
- Prefer event delegation (`$(parent).on('click', 'selector', handler)`).
- Avoid mixing raw DOM and jQuery objects; convert explicitly as needed (`$el[0]`).

## Performance guidelines

- Avoid string building inside loops; compute then `join` outside the loop.
- Minimize DOM reads/writes inside loops; batch updates and use fragments.
- Debounce/throttle expensive event handlers (scroll/resize/input) when needed.
- Prefer pure functions and memoization for hot paths.

## Security and reliability

- Never interpolate unsanitized data into HTML; escape or sanitize first.
- Validate and sanitize all external inputs.
- Don’t log secrets or PII.
- Use `fetch` with proper timeouts/aborts (AbortController) where applicable.

## Naming and file structure

- One primary export per file; file name reflects main export.
- Group by feature/domain, not by type, when creating folders.
- Keep modules small (<200 lines) when practical; refactor if they grow.

## Comments and documentation

- Write JSDoc for public functions, classes, and modules.
- Use `// TODO:` and `// FIXME:` with an owner or ticket reference.
- Don’t restate the obvious; explain intent, invariants, and tricky parts.

Example JSDoc:

```js
/**
 * Formats a user’s display name.
 * @param {{ first: string, last: string }} user
 * @returns {string}
 */
export function formatName({ first, last }) {
	return `${first} ${last}`.trim();
}
```

## Testing

- Use Jest (or equivalent) for unit tests; one test file per module.
- Name tests `*.test.js` or `*.spec.js`; colocate with code or in a tests/ folder.
- Test the public contract; avoid overfitting to implementation details.

## Formatting (Prettier)

- Prettier handles whitespace/formatting; do not fight formatter.
- ESLint handles code-quality rules; Prettier handles style. Use `eslint-config-prettier` to avoid conflicts.

## Import order and examples

```js
// 1) Node built-ins, 2) external packages, 3) internal modules
import fs from 'node:fs';
import path from 'node:path';

import _ from 'lodash';
import dayjs from 'dayjs';

import { formatName } from '../utils/strings.js';

export function main() {
	const users = [
		{ first: 'Ada', last: 'Lovelace' },
		{ first: 'Grace', last: 'Hopper' },
	];

	// Prefer map + join over string concat in loops
	const names = users.map(formatName).join(', ');
	console.log(names);
}
```

## Project-specific overrides

If your project defines additional constraints, layer them on top of this guide. Common overrides:

- Approved libraries only (e.g., jQuery, Lodash, Moment, Font Awesome, Tabulator, Tagify).
- All scripts live under `assets/js/` (no inline JS in HTML templates).
- Use variable function/dispatch-table patterns instead of switch/case for extensibility.
- Follow Node-RED style where applicable: single `msg` argument, modify `msg.payload`.
- Strict rule: do not accumulate strings inside loops; compute once and `join`.

Document any extra rules in your repo’s instructions and ensure ESLint rules align.

---

Questions or proposals? Open a PR that includes rationale, examples, and updated ESLint rules.

