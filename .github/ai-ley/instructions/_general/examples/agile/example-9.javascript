// Agile metrics tracking example
class AgileMetrics {
  calculateVelocity(sprints) {
    const completedStoryPoints = sprints.map(sprint => 
      sprint.completedStories.reduce((sum, story) => sum + story.points, 0)
    );
    return completedStoryPoints.reduce((sum, points) => sum + points) / sprints.length;
  }

  calculateBurndownData(sprint) {
    return sprint.days.map(day => ({
      date: day.date,
      remaining: day.remainingStoryPoints,
      ideal: this.calculateIdealBurndown(sprint, day)
    }));
  }

  calculateCycleTime(workItems) {
    return workItems.map(item => ({
      id: item.id,
      cycleTime: item.completedDate - item.startedDate,
      leadTime: item.completedDate - item.createdDate
    }));
  }
}