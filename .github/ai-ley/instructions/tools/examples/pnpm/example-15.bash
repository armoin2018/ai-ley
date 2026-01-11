# Typical monorepo structure
my-monorepo/
├── pnpm-workspace.yaml
├── package.json
├── packages/
│   ├── ui/
│   │   ├── package.json
│   │   └── src/
│   ├── utils/
│   │   ├── package.json
│   │   └── src/
│   └── shared/
│       ├── package.json
│       └── src/
├── apps/
│   ├── frontend/
│   │   ├── package.json
│   │   └── src/
│   └── backend/
│       ├── package.json
│       └── src/
└── tools/
    ├── eslint-config/
    └── build-tools/