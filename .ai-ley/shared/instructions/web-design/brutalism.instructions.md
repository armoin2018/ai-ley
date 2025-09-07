---
agentMode: general
applyTo: general
author: AI-LEY
description: Awaiting summary.
extensions:
- .md
guidelines: N/A
instructionType: general
keywords: []
lastUpdated: '2025-09-03T00:04:47.978176'
summaryScore: 3.0
title: Brutalism.Instructions
version: 1.0.0
---

# Brutalist Web Design Instructions

## Design Philosophy

- **Style Name**: Brutalist Web Design
- **Version**: Modern Brutalism 2.0
- **Category**: Web Design Movement
- **Purpose**: Create bold, unconventional websites that challenge traditional design conventions
- **Prerequisites**: Strong understanding of CSS Grid, Flexbox, and typography principles

## Core Principles

### Visual Characteristics

- **Typography**: Oversized, bold fonts with mixed weights and unconventional spacing
- **Color Palette**: High contrast, neon colors, and unexpected color combinations
- **Layout**: Broken grids, asymmetrical compositions, overlapping elements
- **Visual Hierarchy**: Intentionally disruptive, anti-conventional organization

### Design Philosophy

- Reject minimalism and clean design trends in favor of raw, honest expression
- Embrace digital imperfection and glitch aesthetics
- Challenge user expectations through unconventional navigation and interaction patterns
- Prioritize artistic expression over traditional usability conventions

## Implementation Guidelines

### Typography System

```css
/* Brutalist Typography Base */
@import url('https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300;400;700&family=JetBrains+Mono:wght@400;700&display=swap');

:root {
  --font-primary: 'Space Grotesk', sans-serif;
  --font-mono: 'JetBrains Mono', monospace;
  --font-size-brutal: clamp(3rem, 8vw, 12rem);
  --font-size-loud: clamp(2rem, 5vw, 6rem);
  --font-size-shout: clamp(1.5rem, 3vw, 3rem);
}

.brutal-heading {
  font-family: var(--font-primary);
  font-size: var(--font-size-brutal);
  font-weight: 700;
  line-height: 0.8;
  letter-spacing: -0.05em;
  text-transform: uppercase;
  mix-blend-mode: difference;
}

.brutal-text {
  font-family: var(--font-mono);
  font-weight: 400;
  line-height: 1.2;
  word-spacing: 0.2em;
}
```

### Color System

```css
/* Brutalist Color Palette */
:root {
  --brutal-neon-green: #39ff14;
  --brutal-electric-blue: #0080ff;
  --brutal-hot-pink: #ff1493;
  --brutal-acid-yellow: #ccff00;
  --brutal-warning-orange: #ff4500;
  --brutal-void-black: #000000;
  --brutal-stark-white: #ffffff;
  --brutal-concrete: #808080;
}

.brutal-bg-primary {
  background: linear-gradient(45deg, 
    var(--brutal-neon-green) 0%, 
    var(--brutal-electric-blue) 50%, 
    var(--brutal-hot-pink) 100%);
  animation: colorShift 3s ease-in-out infinite alternate;
}

@keyframes colorShift {
  0% { filter: hue-rotate(0deg) saturate(100%); }
  100% { filter: hue-rotate(60deg) saturate(150%); }
}
```

### Broken Grid System

```css
/* Anti-Grid Layout System */
.brutal-container {
  display: grid;
  grid-template-columns: repeat(12, 1fr);
  grid-template-rows: repeat(8, minmax(100px, auto));
  gap: 1rem;
  transform: rotate(-0.5deg);
  overflow: hidden;
}

.brutal-element {
  /* Intentionally broken grid positioning */
  grid-column: var(--start-col, 1) / span var(--span-cols, 3);
  grid-row: var(--start-row, 1) / span var(--span-rows, 2);
  transform: 
    rotate(calc(var(--rotate, 0) * 1deg)) 
    skew(calc(var(--skew, 0) * 1deg));
  z-index: var(--layer, 1);
}

/* Overlapping elements */
.brutal-overlap {
  position: relative;
  margin-left: calc(var(--overlap, -20) * 1px);
  margin-top: calc(var(--overlap-y, -10) * 1px);
}
```

## Common Use Cases

### Artist Portfolio Website

**Scenario**: Create unconventional portfolio showcasing creative work
**Implementation**:

```html
<section class="brutal-portfolio">
  <h1 class="brutal-heading" style="--rotate: -3; --skew: 2;">
    CREATIVE\\WORK
  </h1>
  
  <div class="brutal-grid">
    <article class="work-item" style="--start-col: 1; --span-cols: 5; --rotate: 1;">
      <img src="work1.jpg" alt="Project" class="brutal-image">
      <h3>PROJECT_001.EXE</h3>
    </article>
    
    <article class="work-item" style="--start-col: 4; --span-cols: 6; --rotate: -2;">
      <img src="work2.jpg" alt="Project" class="brutal-image">
      <h3>EXPERIMENT.RAW</h3>
    </article>
  </div>
</section>
```

**Expected Result**: Chaotic but purposeful layout that disrupts conventional portfolio presentation

### Experimental Brand Website

**Scenario**: Bold brand identity challenging industry conventions
**Implementation**:

```css
.brand-statement {
  font-size: var(--font-size-brutal);
  background: var(--brutal-void-black);
  color: var(--brutal-neon-green);
  padding: 4rem 2rem;
  text-align: center;
  position: relative;
  overflow: hidden;
}

.brand-statement::before {
  content: "ERROR_404_NORMAL_FOUND";
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%) rotate(45deg);
  font-size: 8rem;
  color: var(--brutal-hot-pink);
  opacity: 0.1;
  pointer-events: none;
}
```

**Expected Result**: Aggressive brand presentation that commands attention and challenges expectations

### Glitch Art Gallery

**Scenario**: Showcase digital art with intentional visual disruption
**Implementation**:

```css
.glitch-gallery {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
  padding: 2rem;
}

.glitch-item {
  position: relative;
  overflow: hidden;
  cursor: pointer;
  transition: all 0.3s ease;
}

.glitch-item:hover {
  animation: glitchEffect 0.5s ease-in-out;
}

@keyframes glitchEffect {
  0%, 100% { transform: translate(0); }
  20% { transform: translate(-2px, 2px); }
  40% { transform: translate(-2px, -2px); }
  60% { transform: translate(2px, 2px); }
  80% { transform: translate(2px, -2px); }
}
```

**Expected Result**: Interactive gallery with purposeful visual disruption effects

## Anti-Patterns to Avoid

- **Overuse Without Purpose**: Applying brutalist elements without strategic intent
- **Accessibility Neglect**: Ignoring basic accessibility while pursuing unconventional design
- **Performance Ignorance**: Creating effects that significantly impact page performance
- **Readability Destruction**: Making content completely unreadable for shock value alone

## Integration & Tools

### Essential Tools

- **Typography**: Google Fonts (Space Grotesk, JetBrains Mono), custom font manipulation
- **Color Tools**: Coolors.co for high-contrast palettes, Adobe Color for neon combinations
- **Animation**: CSS animations, GSAP for complex movement, Three.js for 3D effects
- **Testing**: Cross-browser compatibility testing, accessibility validation tools

### Framework Integration

```javascript
// React component example
import { useState, useEffect } from 'react';

const BrutalistHero = () => {
  const [glitch, setGlitch] = useState(false);
  
  useEffect(() => {
    const interval = setInterval(() => {
      setGlitch(true);
      setTimeout(() => setGlitch(false), 200);
    }, 3000);
    
    return () => clearInterval(interval);
  }, []);
  
  return (
    <section className={`brutal-hero ${glitch ? 'glitch-active' : ''}`}>
      <h1 className="brutal-heading">
        WELCOME\\TO\\THE_FUTURE
      </h1>
    </section>
  );
};
```

## AI Assistant Guidelines

When helping with Brutalist design:

1. **Embrace intentional imperfection** while maintaining functional usability
2. **Provide bold, unconventional examples** that challenge traditional design norms
3. **Include accessibility considerations** even within experimental designs
4. **Suggest performance optimization** for heavy visual effects and animations
5. **Balance shock value with user experience** for practical implementations
6. **Reference digital art movements** and contemporary brutalist examples
7. **Include responsive design** strategies for brutalist layouts
8. **Provide testing guidelines** for cross-browser compatibility

### Code Generation Rules

- Generate CSS that uses modern features (Grid, custom properties, blend modes)
- Include animation and transition effects for dynamic brutalist experiences
- Provide multiple color scheme variations for different brand personalities
- Create modular, reusable component patterns for brutalist design systems
- Include progressive enhancement for users with motion sensitivity or accessibility needs