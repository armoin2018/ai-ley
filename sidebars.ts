import type { SidebarsConfig } from '@docusaurus/plugin-content-docs';

const sidebars: SidebarsConfig = {
  docs: [
    'intro',
    'getting-started',
    {
      type: 'category',
      label: 'Interfaces',
      items: ['interfaces/claude', 'interfaces/copilot'],
      collapsed: false,
    },
  ],
};

export default sidebars;
