// ATS Compatibility Scoring System
class ATSCompatibilityAnalyzer {
  constructor() {
    this.weights = {
      keywordMatch: 0.35,
      formatCompliance: 0.25,
      sectionStructure: 0.2,
      readability: 0.15,
      contentQuality: 0.05,
    };
  }

  analyzeResume(resumeContent, jobRequirements) {
    const scores = {
      keywordMatch: this.analyzeKeywordMatch(resumeContent, jobRequirements),
      formatCompliance: this.analyzeFormat(resumeContent),
      sectionStructure: this.analyzeSections(resumeContent),
      readability: this.analyzeReadability(resumeContent),
      contentQuality: this.analyzeContentQuality(resumeContent),
    };

    const overallScore = this.calculateWeightedScore(scores);

    return {
      overallScore: overallScore,
      detailedScores: scores,
      recommendations: this.generateRecommendations(scores),
      optimizationPriority: this.prioritizeOptimizations(scores),
    };
  }

  analyzeKeywordMatch(resumeContent, jobRequirements) {
    const requiredKeywords = this.extractJobKeywords(jobRequirements);
    const resumeKeywords = this.extractResumeKeywords(resumeContent);

    const matches = requiredKeywords.filter((keyword) =>
      resumeKeywords.includes(keyword.toLowerCase()),
    );

    return {
      score: (matches.length / requiredKeywords.length) * 100,
      matchedKeywords: matches,
      missingKeywords: requiredKeywords.filter(
        (keyword) => !resumeKeywords.includes(keyword.toLowerCase()),
      ),
      recommendations: this.generateKeywordRecommendations(matches, requiredKeywords),
    };
  }
}