import type { Config } from '@docusaurus/types';
import { themes as prismThemes } from 'prism-react-renderer';

const repoOwner = process.env.GITHUB_REPOSITORY?.split('/')[0] ?? 'your-org';
const repoName = process.env.GITHUB_REPOSITORY?.split('/')[1] ?? 'your-repo';

// Adjust these if you publish from a non-default branch or custom domain
const url = `https://${repoOwner}.github.io`;
const baseUrl = `/${repoName}/`;

const config: Config = {
  title: 'Agentic Template',
  tagline: 'Unified templates for Claude & GitHub Copilot',
  favicon: 'img/favicon.ico',

  // GitHub pages deployment config.
  url,
  baseUrl,

  organizationName: repoOwner,
  projectName: repoName,

  // Useful if building per-branch sites (optional)
  trailingSlash: false,

  onBrokenLinks: 'throw',
  onBrokenMarkdownLinks: 'warn',

  i18n: {
    defaultLocale: 'en',
    locales: ['en'],
  },

  presets: [
    [
      'classic',
      {
        docs: {
          sidebarPath: './sidebars.ts',
          routeBasePath: '/docs', // site.com/<baseUrl>/docs
          editUrl: `https://github.com/${repoOwner}/${repoName}/edit/main/`,
        },
        blog: {
          showReadingTime: true,
          routeBasePath: '/blog',
        },
        theme: {
          customCss: [],
        },
      },
    ],
  ],

  themeConfig: {
    image: 'img/social-card.png',
    navbar: {
      title: 'Agentic Template',
      items: [
        { to: '/docs/intro', label: 'Docs', position: 'left' },
        { to: '/blog', label: 'Blog', position: 'left' },
        {
          href: `https://github.com/${repoOwner}/${repoName}`,
          label: 'GitHub',
          position: 'right',
        },
      ],
    },
    footer: {
      style: 'dark',
      links: [
        {
          title: 'Docs',
          items: [
            { label: 'Intro', to: '/docs/intro' },
            { label: 'Getting Started', to: '/docs/getting-started' },
          ],
        },
        {
          title: 'Interfaces',
          items: [
            { label: 'Claude', to: '/docs/interfaces/claude' },
            { label: 'Copilot', to: '/docs/interfaces/copilot' },
          ],
        },
        {
          title: 'Community',
          items: [{ label: 'GitHub', href: `https://github.com/${repoOwner}/${repoName}` }],
        },
      ],
      copyright: `© ${new Date().getFullYear()} ${repoOwner}.`,
    },
    prism: {
      theme: prismThemes.github,
      darkTheme: prismThemes.dracula,
    },
  },
};

export default config;
