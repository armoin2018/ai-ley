// Design tokens approach
const colors = require('./src/tokens/colors.js');
const typography = require('./src/tokens/typography.js');
const spacing = require('./src/tokens/spacing.js');

module.exports = {
  theme: {
    extend: {
      colors: colors,
      fontFamily: typography.fontFamily,
      fontSize: typography.fontSize,
      spacing: spacing,

      // Component-specific tokens
      components: {
        button: {
          borderRadius: '0.5rem',
          padding: {
            sm: '0.5rem 1rem',
            md: '0.75rem 1.5rem',
            lg: '1rem 2rem',
          },
        },
      },
    },
  },
};