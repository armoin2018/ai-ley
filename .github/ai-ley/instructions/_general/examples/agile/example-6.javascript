// Product Backlog Item scoring example
class BacklogItem {
  constructor(title, businessValue, effort, risk, knowledge) {
    this.title = title;
    this.businessValue = businessValue; // 1-10
    this.effort = effort; // 1-13 (Fibonacci)
    this.risk = risk; // 1-5
    this.knowledge = knowledge; // 1-5
  }

  calculatePriority() {
    // Weighted Shortest Job First (WSJF) approach
    const costOfDelay = this.businessValue + this.risk;
    const jobSize = this.effort;
    return costOfDelay / jobSize;
  }

  getComplexityRating() {
    if (this.effort <= 3) return 'Simple';
    if (this.effort <= 8) return 'Medium';
    return 'Complex';
  }
}