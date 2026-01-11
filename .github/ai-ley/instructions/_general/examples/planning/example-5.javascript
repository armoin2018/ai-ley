// Story point estimation guidelines
const storyPointGuidelines = {
  1: {
    description: "Trivial change",
    examples: ["Update text content", "Simple CSS change", "Configuration update"],
    effort: "1-2 hours",
    complexity: "Minimal",
    unknowns: "None"
  },
  2: {
    description: "Minor feature or fix",
    examples: ["Add validation rule", "Simple API endpoint", "Basic UI component"],
    effort: "3-6 hours",
    complexity: "Low",
    unknowns: "Few"
  },
  3: {
    description: "Small feature",
    examples: ["CRUD operations", "Form with validation", "Simple integration"],
    effort: "1-2 days",
    complexity: "Low-Medium",
    unknowns: "Some"
  },
  5: {
    description: "Medium feature",
    examples: ["Complex form", "API with multiple endpoints", "Component library"],
    effort: "3-5 days",
    complexity: "Medium",
    unknowns: "Moderate"
  },
  8: {
    description: "Large feature",
    examples: ["Authentication system", "Reporting module", "Payment integration"],
    effort: "1-2 weeks",
    complexity: "High",
    unknowns: "Significant"
  },
  13: {
    description: "Very large feature",
    examples: ["User management system", "Real-time dashboard", "Mobile app"],
    effort: "2-3 weeks",
    complexity: "Very High",
    unknowns: "Many"
  },
  21: {
    description: "Epic or complex system",
    examples: ["E-commerce platform", "CMS system", "Analytics platform"],
    effort: "1+ months",
    complexity: "Extremely High",
    unknowns: "Should be broken down"
  }
};

// Estimation meeting structure
function planningPoker(storyItems) {
  const results = [];
  
  for (const story of storyItems) {
    console.log(`\n--- Estimating: ${story.title} ---`);
    console.log(`Description: ${story.description}`);
    console.log(`Acceptance Criteria:`);
    story.acceptanceCriteria.forEach((criteria, index) => {
      console.log(`  ${index + 1}. ${criteria}`);
    });
    
    // Team estimation process
    const estimates = collectTeamEstimates(story);
    const finalEstimate = resolveEstimateDiscrepancies(estimates);
    
    results.push({
      ...story,
      estimate: finalEstimate,
      confidence: calculateConfidence(estimates),
      risks: identifyEstimationRisks(story, estimates)
    });
  }
  
  return results;
}