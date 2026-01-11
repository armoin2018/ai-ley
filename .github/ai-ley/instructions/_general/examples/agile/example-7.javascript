// Feature toggle for gradual rollout
class FeatureToggle {
  constructor(configService) {
    this.config = configService;
  }

  isEnabled(featureName, userId = null) {
    const feature = this.config.getFeature(featureName);
    
    if (!feature || !feature.enabled) return false;
    
    // Percentage rollout
    if (feature.percentage && userId) {
      const hash = this.hashUserId(userId);
      return hash < feature.percentage;
    }
    
    // User whitelist
    if (feature.whitelist && userId) {
      return feature.whitelist.includes(userId);
    }
    
    return feature.enabled;
  }
}

// Usage in component
function NewFeatureComponent({ userId }) {
  const isNewFeatureEnabled = useFeatureToggle('new-dashboard', userId);
  
  return isNewFeatureEnabled ? 
    <NewDashboard /> : 
    <LegacyDashboard />;
}