// Issue severity classification system
const severityLevels = {
  P0_CRITICAL: {
    description: "Complete system outage or data loss",
    responseTime: "15 minutes",
    examples: [
      "Production system completely down",
      "Data corruption or loss",
      "Security breach affecting user data",
      "Payment processing failures"
    ],
    escalation: "Immediate executive notification",
    resources: "All hands on deck"
  },
  
  P1_HIGH: {
    description: "Major functionality broken, workaround exists",
    responseTime: "1 hour",
    examples: [
      "Key feature not working but system accessible",
      "Performance degradation >50%",
      "Intermittent payment failures",
      "Authentication issues for some users"
    ],
    escalation: "Manager notification within 30 minutes",
    resources: "Primary on-call engineer"
  },
  
  P2_MEDIUM: {
    description: "Minor functionality issues",
    responseTime: "4 hours",
    examples: [
      "Non-critical feature bugs",
      "UI display issues",
      "Minor performance issues",
      "Documentation errors"
    ],
    escalation: "Standard ticket routing",
    resources: "Standard support queue"
  },
  
  P3_LOW: {
    description: "Enhancement requests or minor bugs",
    responseTime: "24 hours",
    examples: [
      "Feature requests",
      "Cosmetic issues",
      "Nice-to-have improvements",
      "Third-party integration wishes"
    ],
    escalation: "Product team review",
    resources: "Next sprint planning"
  }
};

function classifyIssue(issue) {
  const impactScore = calculateImpact(issue);
  const urgencyScore = calculateUrgency(issue);
  
  // Priority matrix
  if (impactScore >= 9 || urgencyScore >= 9) return severityLevels.P0_CRITICAL;
  if (impactScore >= 7 || urgencyScore >= 7) return severityLevels.P1_HIGH;
  if (impactScore >= 5 || urgencyScore >= 5) return severityLevels.P2_MEDIUM;
  return severityLevels.P3_LOW;
}