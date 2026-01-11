const Base6Card = {
  id: string,
  suit: string, // Color family or category
  rank: number | string, // Numerical or hierarchical value
  space: {
    // Positional properties
    x: number,
    y: number,
    rotation: number,
  },
  image: {
    // Visual elements
    icon: string,
    color: string,
    pattern: string,
  },
  action: string, // Interactive mechanic
  dice: number, // Random element (1-6)
};