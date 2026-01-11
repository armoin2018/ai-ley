// Custom rule example
export default [
  {
    plugins: {
      custom: {
        rules: {
          'no-hardcoded-urls': {
            create(context) {
              return {
                Literal(node) {
                  if (typeof node.value === 'string' && node.value.match(/^https?:\/\//)) {
                    context.report({
                      node,
                      message: 'Hardcoded URLs should be moved to configuration',
                    });
                  }
                },
              };
            },
          },
        },
      },
    },
    rules: {
      'custom/no-hardcoded-urls': 'warn',
    },
  },
];