// Team capacity planning calculator
class CapacityPlanner {
  constructor(teamMembers, sprintLength = 14) {
    this.teamMembers = teamMembers;
    this.sprintLength = sprintLength; // days
    this.workingHoursPerDay = 8;
    this.focusFactors = {
      developer: 0.75, // 75% coding time
      tester: 0.80,    // 80% testing time
      designer: 0.70,  // 70% design time
      pm: 0.60         // 60% project work time
    };
  }

  calculateSprintCapacity(teamMember) {
    const availableDays = this.sprintLength - teamMember.timeOff;
    const totalHours = availableDays * this.workingHoursPerDay;
    const focusFactor = this.focusFactors[teamMember.role] || 0.75;
    
    return {
      member: teamMember.name,
      role: teamMember.role,
      totalHours: totalHours,
      focusedHours: Math.floor(totalHours * focusFactor),
      storyPoints: this.hoursToStoryPoints(totalHours * focusFactor, teamMember.role)
    };
  }

  hoursToStoryPoints(hours, role) {
    // Convert hours to story points based on role and historical velocity
    const roleMultipliers = {
      developer: 0.4,  // 1 story point = 2.5 hours
      tester: 0.5,     // 1 story point = 2 hours  
      designer: 0.3,   // 1 story point = 3.3 hours
      pm: 0.2          // 1 story point = 5 hours
    };
    
    return Math.floor(hours * (roleMultipliers[role] || 0.4));
  }

  planSprint() {
    const capacities = this.teamMembers.map(member => 
      this.calculateSprintCapacity(member)
    );
    
    const totalCapacity = capacities.reduce((sum, cap) => ({
      hours: sum.hours + cap.focusedHours,
      points: sum.points + cap.storyPoints
    }), { hours: 0, points: 0 });

    return {
      individual: capacities,
      team: totalCapacity,
      recommendations: this.getCapacityRecommendations(totalCapacity)
    };
  }

  getCapacityRecommendations(capacity) {
    const recommendations = [];
    
    if (capacity.points < 20) {
      recommendations.push("Low capacity sprint - focus on high-priority items only");
    }
    
    if (capacity.points > 40) {
      recommendations.push("High capacity - consider taking on stretch goals");
    }
    
    recommendations.push(`Reserve ${Math.ceil(capacity.points * 0.2)} points for unexpected work`);
    
    return recommendations;
  }
}

// Usage example
const team = [
  { name: "Alice", role: "developer", timeOff: 1 },
  { name: "Bob", role: "developer", timeOff: 0 },
  { name: "Carol", role: "tester", timeOff: 2 },
  { name: "Dave", role: "designer", timeOff: 0 }
];

const planner = new CapacityPlanner(team);
const sprintPlan = planner.planSprint();
console.log("Sprint Capacity Plan:", sprintPlan);