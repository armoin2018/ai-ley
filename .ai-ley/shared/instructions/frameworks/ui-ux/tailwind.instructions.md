---
applyTo: 'tailwind, tailwindcss, tailwind-css'
agentMode: 'framework-specific'
instructionType: 'guide'
guidelines: 'Focus on Tailwind CSS utility-first framework for custom designs'
---

# Tailwind CSS Framework Instructions for AI Agents

## When to Use Tailwind CSS

Use Tailwind when you need:

- Complete design control with utility-first approach
- Custom designs without pre-built component constraints
- Smaller bundle sizes with automatic purging
- Rapid development with consistent design tokens
- Design systems built from utility primitives
- Projects where developers work closely with designers
- Modern build process integration with PostCSS
- Responsive design with mobile-first utilities

## When to Avoid Tailwind CSS

Consider alternatives when:

- Team prefers component-based CSS frameworks (Bootstrap, Material UI)
- Rapid prototyping with pre-built components is priority
- Learning curve is too steep for team members
- Existing design system conflicts with utility-first approach
- Projects require extensive custom CSS anyway
- Team lacks experience with utility-first methodology
- Legacy browser support without build process

## Framework Overview

- **Framework**: Tailwind CSS
- **Version**: 3.4+
- **Type**: Utility-first CSS framework
- **Language**: CSS with PostCSS, configuration in JavaScript
- **Use Cases**: Custom designs, design systems, modern web applications, component libraries

## Installation & Setup

### ✅ Recommended: npm Installation with PostCSS

```bash
# Install Tailwind CSS and dependencies
npm install -D tailwindcss postcss autoprefixer

# Initialize Tailwind configuration
npx tailwindcss init -p

# This creates:
# - tailwind.config.js (Tailwind configuration)
# - postcss.config.js (PostCSS configuration)
```

### ✅ Tailwind Configuration

```javascript
// tailwind.config.js - Complete configuration
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './src/**/*.{html,js,ts,jsx,tsx,vue,svelte}',
    './public/index.html',
    './components/**/*.{js,ts,jsx,tsx}',
  ],

  theme: {
    extend: {
      // Custom colors
      colors: {
        primary: {
          50: '#eff6ff',
          100: '#dbeafe',
          200: '#bfdbfe',
          300: '#93c5fd',
          400: '#60a5fa',
          500: '#3b82f6',
          600: '#2563eb',
          700: '#1d4ed8',
          800: '#1e40af',
          900: '#1e3a8a',
          950: '#172554',
        },
        gray: {
          50: '#f9fafb',
          100: '#f3f4f6',
          200: '#e5e7eb',
          300: '#d1d5db',
          400: '#9ca3af',
          500: '#6b7280',
          600: '#4b5563',
          700: '#374151',
          800: '#1f2937',
          900: '#111827',
          950: '#030712',
        },
      },

      // Custom fonts
      fontFamily: {
        sans: ['Inter', 'system-ui', 'sans-serif'],
        display: ['Lexend', 'system-ui', 'sans-serif'],
        mono: ['Fira Code', 'monospace'],
      },

      // Custom spacing
      spacing: {
        18: '4.5rem',
        88: '22rem',
        128: '32rem',
      },

      // Custom animations
      animation: {
        'fade-in': 'fadeIn 0.5s ease-in-out',
        'slide-up': 'slideUp 0.3s ease-out',
        'bounce-gentle': 'bounceGentle 1s ease-in-out infinite',
      },

      keyframes: {
        fadeIn: {
          '0%': { opacity: '0' },
          '100%': { opacity: '1' },
        },
        slideUp: {
          '0%': { transform: 'translateY(10px)', opacity: '0' },
          '100%': { transform: 'translateY(0)', opacity: '1' },
        },
        bounceGentle: {
          '0%, 100%': { transform: 'translateY(-5%)' },
          '50%': { transform: 'translateY(0)' },
        },
      },

      // Custom breakpoints
      screens: {
        xs: '475px',
        '3xl': '1600px',
      },
    },
  },

  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/container-queries'),
  ],

  // Safelist important utilities that might be dynamically generated
  safelist: ['text-red-500', 'text-green-500', 'bg-red-100', 'bg-green-100'],
};
```

### ✅ CSS Setup

```css
/* src/styles/tailwind.css - Base styles with custom utilities */
@tailwind base;
@tailwind components;
@tailwind utilities;

/* Custom base styles */
@layer base {
  html {
    @apply scroll-smooth;
  }

  body {
    @apply bg-white text-gray-900 font-sans antialiased;
  }

  h1,
  h2,
  h3,
  h4,
  h5,
  h6 {
    @apply font-display font-semibold tracking-tight;
  }

  h1 {
    @apply text-4xl md:text-5xl lg:text-6xl;
  }
  h2 {
    @apply text-3xl md:text-4xl lg:text-5xl;
  }
  h3 {
    @apply text-2xl md:text-3xl lg:text-4xl;
  }
  h4 {
    @apply text-xl md:text-2xl;
  }
  h5 {
    @apply text-lg md:text-xl;
  }
  h6 {
    @apply text-base md:text-lg;
  }

  /* Focus styles for accessibility */
  button:focus-visible,
  a:focus-visible,
  input:focus-visible,
  textarea:focus-visible,
  select:focus-visible {
    @apply outline-none ring-2 ring-primary-500 ring-offset-2;
  }
}

/* Custom component styles */
@layer components {
  .btn {
    @apply inline-flex items-center justify-center px-4 py-2 text-sm font-medium rounded-lg transition-all duration-200 focus:outline-none focus:ring-2 focus:ring-offset-2 disabled:opacity-50 disabled:cursor-not-allowed;
  }

  .btn-primary {
    @apply bg-primary-600 text-white hover:bg-primary-700 focus:ring-primary-500 active:bg-primary-800;
  }

  .btn-secondary {
    @apply bg-gray-200 text-gray-900 hover:bg-gray-300 focus:ring-gray-500 active:bg-gray-400;
  }

  .btn-outline {
    @apply border border-gray-300 text-gray-700 hover:bg-gray-50 focus:ring-gray-500;
  }

  .card {
    @apply bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden;
  }

  .card-header {
    @apply px-6 py-4 border-b border-gray-200 bg-gray-50;
  }

  .card-body {
    @apply px-6 py-4;
  }

  .form-input {
    @apply block w-full px-3 py-2 border border-gray-300 rounded-lg shadow-sm placeholder-gray-400 focus:outline-none focus:ring-primary-500 focus:border-primary-500;
  }

  .form-label {
    @apply block text-sm font-medium text-gray-700 mb-1;
  }

  .form-error {
    @apply text-sm text-red-600 mt-1;
  }
}

/* Custom utilities */
@layer utilities {
  .text-balance {
    text-wrap: balance;
  }

  .text-gradient {
    @apply bg-gradient-to-r from-primary-600 to-purple-600 bg-clip-text text-transparent;
  }

  .glass {
    @apply bg-white/20 backdrop-blur-md border border-white/30;
  }

  .perspective-1000 {
    perspective: 1000px;
  }

  .transform-preserve-3d {
    transform-style: preserve-3d;
  }
}
```

### AI Agent Decision Tree

- **For custom designs**: Use Tailwind with design system tokens
- **For rapid prototyping**: Consider component library built on Tailwind (Headless UI, Radix)
- **For existing projects**: Gradual adoption alongside existing CSS
- **For teams new to utility-first**: Start with component classes in @layer components
- **For performance-critical apps**: Use JIT mode and proper purging configuration

## Project Structure

### ✅ Basic Tailwind Project

```
tailwind-project/
├── tailwind.config.js      # Tailwind configuration
├── postcss.config.js       # PostCSS configuration
├── package.json            # Dependencies
├── src/
│   ├── styles/
│   │   ├── tailwind.css    # Main CSS file
│   │   └── components.css  # Component styles
│   ├── js/
│   │   └── main.js         # JavaScript entry
│   └── index.html          # HTML files
├── dist/                   # Built files
└── assets/                 # Static assets
```

### ✅ Advanced Project with Design System

```
design-system-project/
├── tailwind.config.js
├── postcss.config.js
├── src/
│   ├── styles/
│   │   ├── tailwind.css
│   │   ├── base.css        # Base layer customizations
│   │   ├── components.css  # Component layer
│   │   └── utilities.css   # Utility layer
│   ├── components/         # Component library
│   │   ├── Button.js
│   │   ├── Card.js
│   │   ├── Modal.js
│   │   └── Form/
│   │       ├── Input.js
│   │       ├── Select.js
│   │       └── TextArea.js
│   ├── tokens/             # Design tokens
│   │   ├── colors.js
│   │   ├── typography.js
│   │   └── spacing.js
│   └── utils/              # Utility functions
├── stories/                # Storybook stories
└── tests/                  # Component tests
```

## Core Concepts

### Utility-First Development Approach

✅ **Best Practice**: Build complex components using utility classes

```html
<!-- Traditional CSS approach vs Tailwind approach -->

<!-- Tailwind: Utility-first card component -->
<div class="max-w-sm mx-auto bg-white rounded-xl shadow-md overflow-hidden">
  <div class="md:flex">
    <div class="md:shrink-0">
      <img class="h-48 w-full object-cover md:h-full md:w-48" src="image.jpg" alt="Card image" />
    </div>
    <div class="p-8">
      <div class="uppercase tracking-wide text-sm text-indigo-500 font-semibold">
        Company retreat
      </div>
      <a href="#" class="block mt-1 text-lg leading-tight font-medium text-black hover:underline">
        Incredible accommodation for your team
      </a>
      <p class="mt-2 text-gray-500">
        Looking to take your team away on a retreat to enjoy awesome food and take in some sunshine?
        We have a list of places to do just that.
      </p>
    </div>
  </div>
</div>

<!-- Advanced responsive grid layout -->
<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 p-6">
  <div
    class="group relative overflow-hidden rounded-2xl bg-gradient-to-br from-blue-50 to-indigo-100 p-6 hover:shadow-xl transition-all duration-300"
  >
    <div
      class="absolute inset-0 bg-gradient-to-br from-blue-600/10 to-purple-600/10 opacity-0 group-hover:opacity-100 transition-opacity duration-300"
    ></div>

    <div class="relative z-10">
      <div
        class="w-12 h-12 bg-blue-500 rounded-lg flex items-center justify-center mb-4 group-hover:scale-110 transition-transform duration-300"
      >
        <svg class="w-6 h-6 text-white" fill="currentColor" viewBox="0 0 20 20">
          <path d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
        </svg>
      </div>

      <h3
        class="text-xl font-semibold text-gray-900 mb-2 group-hover:text-blue-600 transition-colors duration-300"
      >
        Feature Title
      </h3>

      <p class="text-gray-600 leading-relaxed">
        Description of the feature with proper typography and spacing using Tailwind utilities.
      </p>

      <div class="mt-4 pt-4 border-t border-gray-200">
        <a
          href="#"
          class="inline-flex items-center text-blue-600 hover:text-blue-800 font-medium transition-colors duration-200"
        >
          Learn more
          <svg
            class="ml-2 w-4 h-4 group-hover:translate-x-1 transition-transform duration-200"
            fill="currentColor"
            viewBox="0 0 20 20"
          >
            <path
              fill-rule="evenodd"
              d="M10.293 3.293a1 1 0 011.414 0l6 6a1 1 0 010 1.414l-6 6a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-4.293-4.293a1 1 0 010-1.414z"
              clip-rule="evenodd"
            ></path>
          </svg>
        </a>
      </div>
    </div>
  </div>
</div>
```

### Responsive Design with Mobile-First Approach

✅ **Best Practice**: Design for mobile first, then enhance for larger screens

```html
<!-- Mobile-first responsive component -->
<nav class="bg-white shadow-lg">
  <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
    <div class="flex justify-between h-16">
      <!-- Logo -->
      <div class="flex items-center">
        <img class="h-8 w-auto" src="logo.svg" alt="Company" />
        <span class="ml-2 text-xl font-bold text-gray-900 hidden sm:block">Company</span>
      </div>

      <!-- Desktop navigation -->
      <div class="hidden md:flex items-center space-x-8">
        <a
          href="#"
          class="text-gray-900 hover:text-primary-600 px-3 py-2 text-sm font-medium transition-colors duration-200"
        >
          Home
        </a>
        <a
          href="#"
          class="text-gray-500 hover:text-gray-900 px-3 py-2 text-sm font-medium transition-colors duration-200"
        >
          About
        </a>
        <a
          href="#"
          class="text-gray-500 hover:text-gray-900 px-3 py-2 text-sm font-medium transition-colors duration-200"
        >
          Services
        </a>
        <a
          href="#"
          class="text-gray-500 hover:text-gray-900 px-3 py-2 text-sm font-medium transition-colors duration-200"
        >
          Contact
        </a>
      </div>

      <!-- Mobile menu button -->
      <div class="md:hidden flex items-center">
        <button
          class="text-gray-500 hover:text-gray-900 focus:outline-none focus:text-gray-900 p-2"
        >
          <svg class="h-6 w-6" stroke="currentColor" fill="none" viewBox="0 0 24 24">
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M4 6h16M4 12h16M4 18h16"
            ></path>
          </svg>
        </button>
      </div>
    </div>
  </div>

  <!-- Mobile menu (hidden by default) -->
  <div class="md:hidden hidden">
    <div class="px-2 pt-2 pb-3 space-y-1 sm:px-3 bg-gray-50">
      <a
        href="#"
        class="block px-3 py-2 text-base font-medium text-gray-900 hover:bg-gray-100 rounded-md"
        >Home</a
      >
      <a
        href="#"
        class="block px-3 py-2 text-base font-medium text-gray-500 hover:text-gray-900 hover:bg-gray-100 rounded-md"
        >About</a
      >
      <a
        href="#"
        class="block px-3 py-2 text-base font-medium text-gray-500 hover:text-gray-900 hover:bg-gray-100 rounded-md"
        >Services</a
      >
      <a
        href="#"
        class="block px-3 py-2 text-base font-medium text-gray-500 hover:text-gray-900 hover:bg-gray-100 rounded-md"
        >Contact</a
      >
    </div>
  </div>
</nav>

<!-- Responsive form layout -->
<div class="min-h-screen bg-gray-50 flex flex-col justify-center py-12 sm:px-6 lg:px-8">
  <div class="sm:mx-auto sm:w-full sm:max-w-md">
    <h2 class="mt-6 text-center text-3xl font-bold text-gray-900">Sign in to your account</h2>
  </div>

  <div class="mt-8 sm:mx-auto sm:w-full sm:max-w-md">
    <div class="bg-white py-8 px-4 shadow sm:rounded-lg sm:px-10">
      <form class="space-y-6">
        <div>
          <label for="email" class="form-label">Email address</label>
          <input
            id="email"
            name="email"
            type="email"
            required
            class="form-input"
            placeholder="Enter your email"
          />
        </div>

        <div>
          <label for="password" class="form-label">Password</label>
          <input
            id="password"
            name="password"
            type="password"
            required
            class="form-input"
            placeholder="Enter your password"
          />
        </div>

        <div class="flex items-center justify-between">
          <div class="flex items-center">
            <input
              id="remember-me"
              name="remember-me"
              type="checkbox"
              class="h-4 w-4 text-primary-600 focus:ring-primary-500 border-gray-300 rounded"
            />
            <label for="remember-me" class="ml-2 block text-sm text-gray-900"> Remember me </label>
          </div>

          <div class="text-sm">
            <a href="#" class="font-medium text-primary-600 hover:text-primary-500">
              Forgot your password?
            </a>
          </div>
        </div>

        <div>
          <button type="submit" class="btn btn-primary w-full">Sign in</button>
        </div>
      </form>
    </div>
  </div>
</div>
```

### Component Composition and Reusability

✅ **Best Practice**: Create reusable component patterns

```html
<!-- Modal component with Tailwind -->
<div class="fixed inset-0 z-50 overflow-y-auto" x-show="showModal" x-cloak>
  <!-- Backdrop -->
  <div
    class="fixed inset-0 bg-black bg-opacity-50 transition-opacity"
    x-show="showModal"
    x-transition:enter="ease-out duration-300"
    x-transition:enter-start="opacity-0"
    x-transition:enter-end="opacity-100"
    x-transition:leave="ease-in duration-200"
    x-transition:leave-start="opacity-100"
    x-transition:leave-end="opacity-0"
    @click="showModal = false"
  ></div>

  <!-- Modal content -->
  <div class="flex min-h-full items-center justify-center p-4 text-center">
    <div
      class="w-full max-w-md transform overflow-hidden rounded-2xl bg-white p-6 text-left align-middle shadow-xl transition-all"
      x-show="showModal"
      x-transition:enter="ease-out duration-300"
      x-transition:enter-start="opacity-0 scale-95"
      x-transition:enter-end="opacity-100 scale-100"
      x-transition:leave="ease-in duration-200"
      x-transition:leave-start="opacity-100 scale-100"
      x-transition:leave-end="opacity-0 scale-95"
    >
      <div class="flex items-center justify-between mb-4">
        <h3 class="text-lg font-semibold text-gray-900">Modal Title</h3>
        <button
          @click="showModal = false"
          class="text-gray-400 hover:text-gray-600 transition-colors duration-200"
        >
          <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M6 18L18 6M6 6l12 12"
            ></path>
          </svg>
        </button>
      </div>

      <div class="mb-6">
        <p class="text-gray-600">
          Modal content goes here. This is a reusable modal component built with Tailwind CSS
          utilities.
        </p>
      </div>

      <div class="flex justify-end space-x-3">
        <button @click="showModal = false" class="btn btn-secondary">Cancel</button>
        <button @click="handleSubmit()" class="btn btn-primary">Confirm</button>
      </div>
    </div>
  </div>
</div>

<!-- Data table component -->
<div class="bg-white shadow-sm rounded-lg overflow-hidden">
  <div class="px-6 py-4 border-b border-gray-200">
    <div class="flex items-center justify-between">
      <h3 class="text-lg font-semibold text-gray-900">Users</h3>
      <button class="btn btn-primary">Add User</button>
    </div>
  </div>

  <div class="overflow-x-auto">
    <table class="min-w-full divide-y divide-gray-200">
      <thead class="bg-gray-50">
        <tr>
          <th
            class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
          >
            Name
          </th>
          <th
            class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
          >
            Email
          </th>
          <th
            class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
          >
            Role
          </th>
          <th class="relative px-6 py-3"><span class="sr-only">Actions</span></th>
        </tr>
      </thead>
      <tbody class="bg-white divide-y divide-gray-200">
        <tr class="hover:bg-gray-50 transition-colors duration-200">
          <td class="px-6 py-4 whitespace-nowrap">
            <div class="flex items-center">
              <img class="h-10 w-10 rounded-full" src="avatar1.jpg" alt="" />
              <div class="ml-4">
                <div class="text-sm font-medium text-gray-900">John Doe</div>
                <div class="text-sm text-gray-500">Software Engineer</div>
              </div>
            </div>
          </td>
          <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">john@example.com</td>
          <td class="px-6 py-4 whitespace-nowrap">
            <span
              class="inline-flex px-2 py-1 text-xs font-semibold rounded-full bg-green-100 text-green-800"
            >
              Admin
            </span>
          </td>
          <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
            <button class="text-primary-600 hover:text-primary-900 mr-3">Edit</button>
            <button class="text-red-600 hover:text-red-900">Delete</button>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</div>
```

## Best Practices

### ✅ Do's

- Use consistent spacing scale (4, 8, 12, 16, 20, 24, etc.)
- Leverage design tokens for colors, typography, and spacing
- Create component classes for frequently used patterns
- Use responsive prefixes for mobile-first design
- Implement proper focus states for accessibility
- Use CSS custom properties for dynamic values
- Optimize bundle size with proper purging configuration
- Follow consistent naming conventions for custom utilities

### ❌ Don'ts

- Don't use arbitrary values excessively (use design tokens)
- Don't create overly complex utility combinations (extract to components)
- Don't ignore responsive design principles
- Don't forget to configure content paths for proper purging
- Don't override Tailwind classes with custom CSS unnecessarily
- Don't use `!important` unless absolutely necessary
- Don't forget accessibility considerations in utility usage
- Don't mix different spacing scales inconsistently

### Performance and Optimization

```javascript
// tailwind.config.js - Production optimization
module.exports = {
  content: [
    // Be specific about content paths for better purging
    './src/**/*.{html,js,ts,jsx,tsx,vue,svelte}',
    './public/index.html',
  ],

  // Use safelist sparingly - only for dynamic classes
  safelist: [
    {
      pattern: /bg-(red|green|blue)-(100|500|900)/,
      variants: ['hover', 'focus'],
    },
  ],

  theme: {
    extend: {
      // Only add what you need
      colors: {
        brand: {
          50: '#eff6ff',
          500: '#3b82f6',
          900: '#1e3a8a',
        },
      },
    },
  },

  plugins: [
    // Only include plugins you actually use
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
  ],
};
```

## Development Workflow

### ✅ Tailwind Development Process

```bash
# 1. Setup development environment
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p

# 2. Development build with watch
npx tailwindcss -i ./src/styles/tailwind.css -o ./dist/output.css --watch

# 3. Production build with minification
npx tailwindcss -i ./src/styles/tailwind.css -o ./dist/output.css --minify

# 4. Build integration with popular tools
npm run dev          # Vite/webpack dev server
npm run build        # Production build
npm run preview      # Preview build

# 5. Analyze bundle size
npm install -D @tailwindcss/typography
npx tailwindcss -i input.css -o output.css --content './src/**/*.html' --verbose
```

### Design Token System Integration

```javascript
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
```

## AI Agent Decision Matrix

| Scenario                         | Recommended Approach             | Avoid                              |
| -------------------------------- | -------------------------------- | ---------------------------------- |
| Custom design system             | Tailwind with custom tokens      | Pre-built component frameworks     |
| Rapid prototyping                | Tailwind + headless components   | Building everything from scratch   |
| Developer-first team             | Pure utility approach            | Complex component abstractions     |
| Designer-developer collaboration | Design tokens + utilities        | Disconnected design and code       |
| Performance-critical sites       | JIT mode + proper purging        | Unused utility bloat               |
| Accessibility-first projects     | Tailwind + proper ARIA + testing | Utility-only without semantic HTML |
| Large-scale applications         | Component library + utilities    | Inline utilities everywhere        |
| Maintenance-heavy projects       | Well-documented component system | Ad-hoc utility combinations        |

## Integration Points

### React Integration

```jsx
// React component with Tailwind
import { useState } from 'react';
import { clsx } from 'clsx';

const Button = ({
  children,
  variant = 'primary',
  size = 'md',
  disabled = false,
  className = '',
  ...props
}) => {
  const baseClasses =
    'inline-flex items-center justify-center font-medium rounded-lg transition-all duration-200 focus:outline-none focus:ring-2 focus:ring-offset-2 disabled:opacity-50 disabled:cursor-not-allowed';

  const variants = {
    primary: 'bg-blue-600 text-white hover:bg-blue-700 focus:ring-blue-500 active:bg-blue-800',
    secondary: 'bg-gray-200 text-gray-900 hover:bg-gray-300 focus:ring-gray-500 active:bg-gray-400',
    outline: 'border border-gray-300 text-gray-700 hover:bg-gray-50 focus:ring-gray-500',
    ghost: 'text-gray-700 hover:bg-gray-100 focus:ring-gray-500',
  };

  const sizes = {
    sm: 'px-3 py-1.5 text-sm',
    md: 'px-4 py-2 text-sm',
    lg: 'px-6 py-3 text-base',
    xl: 'px-8 py-4 text-lg',
  };

  return (
    <button
      className={clsx(baseClasses, variants[variant], sizes[size], className)}
      disabled={disabled}
      {...props}
    >
      {children}
    </button>
  );
};

// Usage with Tailwind utilities
const App = () => {
  const [isLoading, setIsLoading] = useState(false);

  return (
    <div className="min-h-screen bg-gray-50 flex items-center justify-center p-4">
      <div className="max-w-md w-full bg-white rounded-xl shadow-lg p-6">
        <div className="text-center mb-6">
          <h1 className="text-2xl font-bold text-gray-900 mb-2">Welcome Back</h1>
          <p className="text-gray-600">Sign in to your account</p>
        </div>

        <form className="space-y-4">
          <div>
            <label className="form-label">Email</label>
            <input type="email" className="form-input" placeholder="Enter your email" />
          </div>

          <div>
            <label className="form-label">Password</label>
            <input type="password" className="form-input" placeholder="Enter your password" />
          </div>

          <Button variant="primary" size="lg" disabled={isLoading} className="w-full mt-6">
            {isLoading ? (
              <>
                <svg
                  className="animate-spin -ml-1 mr-3 h-5 w-5 text-white"
                  xmlns="http://www.w3.org/2000/svg"
                  fill="none"
                  viewBox="0 0 24 24"
                >
                  <circle
                    className="opacity-25"
                    cx="12"
                    cy="12"
                    r="10"
                    stroke="currentColor"
                    strokeWidth="4"
                  ></circle>
                  <path
                    className="opacity-75"
                    fill="currentColor"
                    d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
                  ></path>
                </svg>
                Signing in...
              </>
            ) : (
              'Sign In'
            )}
          </Button>
        </form>
      </div>
    </div>
  );
};
```

### Vue.js Integration

```vue
<template>
  <div class="max-w-2xl mx-auto p-6">
    <!-- Dynamic classes with Vue -->
    <div
      :class="[
        'p-4 rounded-lg border transition-all duration-200',
        alertType === 'success' ? 'bg-green-50 border-green-200 text-green-800' : '',
        alertType === 'error' ? 'bg-red-50 border-red-200 text-red-800' : '',
        alertType === 'warning' ? 'bg-yellow-50 border-yellow-200 text-yellow-800' : '',
        isVisible ? 'opacity-100 translate-y-0' : 'opacity-0 -translate-y-2',
      ]"
      v-if="showAlert"
    >
      <div class="flex items-center">
        <svg
          :class="[
            'w-5 h-5 mr-2',
            alertType === 'success' ? 'text-green-400' : '',
            alertType === 'error' ? 'text-red-400' : '',
            alertType === 'warning' ? 'text-yellow-400' : '',
          ]"
          fill="currentColor"
          viewBox="0 0 20 20"
        >
          <path
            fill-rule="evenodd"
            d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z"
            clip-rule="evenodd"
          ></path>
        </svg>
        {{ alertMessage }}
      </div>
    </div>

    <!-- Form with Tailwind validation styles -->
    <form @submit.prevent="submitForm" class="mt-6 space-y-6">
      <div>
        <label for="name" class="form-label">Name</label>
        <input
          v-model="form.name"
          :class="[
            'form-input',
            errors.name ? 'border-red-300 focus:border-red-500 focus:ring-red-500' : '',
          ]"
          type="text"
          id="name"
          placeholder="Enter your name"
        />
        <p v-if="errors.name" class="form-error">{{ errors.name }}</p>
      </div>

      <div>
        <label for="email" class="form-label">Email</label>
        <input
          v-model="form.email"
          :class="[
            'form-input',
            errors.email ? 'border-red-300 focus:border-red-500 focus:ring-red-500' : '',
          ]"
          type="email"
          id="email"
          placeholder="Enter your email"
        />
        <p v-if="errors.email" class="form-error">{{ errors.email }}</p>
      </div>

      <button
        type="submit"
        :disabled="isSubmitting"
        :class="['btn w-full', isSubmitting ? 'btn-secondary' : 'btn-primary']"
      >
        <svg
          v-if="isSubmitting"
          class="animate-spin -ml-1 mr-3 h-5 w-5"
          fill="none"
          viewBox="0 0 24 24"
        >
          <circle
            class="opacity-25"
            cx="12"
            cy="12"
            r="10"
            stroke="currentColor"
            stroke-width="4"
          ></circle>
          <path
            class="opacity-75"
            fill="currentColor"
            d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
          ></path>
        </svg>
        {{ isSubmitting ? 'Submitting...' : 'Submit' }}
      </button>
    </form>
  </div>
</template>

<script>
export default {
  data() {
    return {
      form: {
        name: '',
        email: '',
      },
      errors: {},
      isSubmitting: false,
      showAlert: false,
      alertType: 'success',
      alertMessage: '',
      isVisible: false,
    };
  },

  methods: {
    validateForm() {
      this.errors = {};

      if (!this.form.name.trim()) {
        this.errors.name = 'Name is required';
      }

      if (!this.form.email.trim()) {
        this.errors.email = 'Email is required';
      } else if (!/\S+@\S+\.\S+/.test(this.form.email)) {
        this.errors.email = 'Please enter a valid email';
      }

      return Object.keys(this.errors).length === 0;
    },

    async submitForm() {
      if (!this.validateForm()) return;

      this.isSubmitting = true;

      try {
        // Simulate API call
        await new Promise((resolve) => setTimeout(resolve, 1500));

        this.showAlert('success', 'Form submitted successfully!');
        this.form = { name: '', email: '' };
      } catch (error) {
        this.showAlert('error', 'Something went wrong. Please try again.');
      } finally {
        this.isSubmitting = false;
      }
    },

    showAlert(type, message) {
      this.alertType = type;
      this.alertMessage = message;
      this.showAlert = true;

      // Trigger animation
      this.$nextTick(() => {
        this.isVisible = true;
      });

      // Auto-hide after 5 seconds
      setTimeout(() => {
        this.isVisible = false;
        setTimeout(() => {
          this.showAlert = false;
        }, 200);
      }, 5000);
    },
  },
};
</script>
```

## Version Compatibility and Ecosystem

- **Tailwind CSS**: 3.4+ (latest features with container queries, arbitrary properties)
- **PostCSS**: 8.0+ for build process
- **Node.js**: 16+ for build tools
- **Browser Support**: All modern browsers, IE11+ with autoprefixer

### Plugin Ecosystem

```bash
# Essential Tailwind plugins
npm install -D @tailwindcss/forms          # Better form styling
npm install -D @tailwindcss/typography     # Prose styling
npm install -D @tailwindcss/aspect-ratio   # Aspect ratio utilities
npm install -D @tailwindcss/container-queries # Container query support

# Community plugins
npm install -D @tailwindcss/line-clamp     # Text truncation
npm install -D tailwindcss-animate         # Animation utilities
npm install -D tailwind-scrollbar-hide     # Scrollbar utilities
```

## Performance Optimization

- Configure proper content paths for optimal purging
- Use JIT mode for development speed and production optimization
- Implement proper component abstraction to reduce utility repetition
- Use CSS custom properties for dynamic values instead of arbitrary properties
- Optimize build process with PostCSS plugins
- Monitor bundle size and remove unused plugins
- Implement proper caching strategies for CSS assets

## Security Considerations

- Validate all user inputs regardless of Tailwind styling
- Implement proper content security policy (CSP) for styles
- Use Tailwind's built-in purging to prevent style injection attacks
- Regular updates to Tailwind and PostCSS for security patches
- Sanitize dynamic class names from user input
- Implement proper access controls for admin interfaces

## AI Agent Quick Reference

- **Design System**: Use Tailwind as foundation for consistent design tokens and spacing
- **Component Strategy**: Create reusable component classes in @layer components for common patterns
- **Responsive Design**: Always use mobile-first approach with proper breakpoint consideration
- **Performance**: Configure proper purging and use JIT mode for optimal build sizes
- **Accessibility**: Combine Tailwind utilities with proper semantic HTML and ARIA attributes
- **Integration**: Adapt Tailwind patterns to work seamlessly with component frameworks and build tools

### [Pattern Name]

```[language]
// Example implementation
[code example]
```

### [Pattern Name]

```[language]
// Example implementation
[code example]
```

## Configuration

### [Config File 1]

```[format]
# Configuration options
[example configuration]
```

### [Config File 2]

```[format]
# Configuration options
[example configuration]
```

## Essential Commands

```bash
# Development
[dev server command]

# Testing
[test command]

# Building
[build command]

# Linting
[lint command]

# Package management
[install dependencies]
[add new package]
[update packages]
```

## Common Issues & Solutions

### [Issue 1]

**Problem**: [Description of the problem]
**Solution**: [How to solve it]

### [Issue 2]

**Problem**: [Description of the problem]
**Solution**: [How to solve it]

## Performance Optimization

- [Optimization technique 1]
- [Optimization technique 2]
- [Optimization technique 3]

## Security Considerations

- [Security best practice 1]
- [Security best practice 2]
- [Security best practice 3]

## Useful Resources

- **Official Documentation**: [URL]
- **Community Resources**: [URLs]
- **Learning Materials**: [URLs]
- **Tools & Extensions**: [List of helpful tools]

## Framework-Specific Guidelines

### Code Style

- [Coding conventions specific to this framework]
- [Naming conventions]
- [File organization patterns]

### Architecture Patterns

- [Recommended architectural patterns]
- [State management approaches]
- [Component/module organization]

## Integration Points

### [External Service/Tool 1]

- **Purpose**: [What it integrates with]
- **Setup**: [How to configure]
- **Usage**: [Implementation examples]

### [External Service/Tool 2]

- **Purpose**: [What it integrates with]
- **Setup**: [How to configure]
- **Usage**: [Implementation examples]

## Version Compatibility

- **Node.js**: [Supported versions]
- **Dependencies**: [Key dependency versions]
- **Browser Support**: [If applicable]
- **OS Support**: [If applicable]

## Troubleshooting

### Debug Mode

```bash
[debug commands]
```

### Log Analysis

- [Where to find logs]
- [How to interpret common error messages]

### Common Error Messages

- **Error**: `[error message]`
  **Cause**: [Why this happens]
  **Solution**: [How to fix]
