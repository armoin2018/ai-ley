const analytics = new EnterpriseTestAnalytics();
const report = analytics.generate_comprehensive_report(testResults);

// Detailed reporting and insights
expect(report.security_score).toBeGreaterThan(0.95);
expect(report.quality_score).toBeGreaterThan(0.9);
expect(report.performance_score).toBeGreaterThan(0.85);