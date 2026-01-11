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