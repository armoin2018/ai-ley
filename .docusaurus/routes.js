import React from 'react';
import ComponentCreator from '@docusaurus/ComponentCreator';

export default [
  {
    path: '/blog',
    component: ComponentCreator('/blog', '4c0'),
    exact: true
  },
  {
    path: '/blog/2025/08/12/welcome',
    component: ComponentCreator('/blog/2025/08/12/welcome', '480'),
    exact: true
  },
  {
    path: '/blog/archive',
    component: ComponentCreator('/blog/archive', '182'),
    exact: true
  },
  {
    path: '/docs',
    component: ComponentCreator('/docs', '9cf'),
    routes: [
      {
        path: '/docs',
        component: ComponentCreator('/docs', '7c2'),
        routes: [
          {
            path: '/docs',
            component: ComponentCreator('/docs', '131'),
            routes: [
              {
                path: '/docs/getting-started',
                component: ComponentCreator('/docs/getting-started', '2a1'),
                exact: true,
                sidebar: "tutorialSidebar"
              },
              {
                path: '/docs/interfaces/claude',
                component: ComponentCreator('/docs/interfaces/claude', 'a38'),
                exact: true,
                sidebar: "tutorialSidebar"
              },
              {
                path: '/docs/interfaces/copilot',
                component: ComponentCreator('/docs/interfaces/copilot', '69c'),
                exact: true,
                sidebar: "tutorialSidebar"
              },
              {
                path: '/docs/intro',
                component: ComponentCreator('/docs/intro', '61d'),
                exact: true,
                sidebar: "tutorialSidebar"
              }
            ]
          }
        ]
      }
    ]
  },
  {
    path: '/',
    component: ComponentCreator('/', 'e5f'),
    exact: true
  },
  {
    path: '*',
    component: ComponentCreator('*'),
  },
];
