def should_use_chef(requirements)
  # Strongly recommended for enterprise environments with Ruby expertise
  strongly_recommended = [
    requirements[:enterprise_environment],
    requirements[:ruby_expertise_available],
    requirements[:policy_as_code_requirements],
    requirements[:compliance_automation_needed],
    requirements[:existing_chef_infrastructure],
    requirements[:complex_multi_platform_support],
    requirements[:advanced_testing_requirements]
  ]

  if strongly_recommended.any?
    return {
      recommended: true,
      reason: "Chef excels in enterprise environments with strong Ruby expertise and complex compliance requirements"
    }
  end

  # Consider alternatives if needed
  alternatives_needed = [
    requirements[:simple_automation_needs],
    requirements[:python_team_preference],
    requirements[:immediate_execution_required],
    requirements[:limited_ruby_knowledge],
    requirements[:small_infrastructure],
    requirements[:cloud_native_workloads]
  ]

  if alternatives_needed.any?
    return {
      recommended: false,
      reason: "Consider Ansible for simpler needs, Terraform for cloud infrastructure, or Kubernetes operators for cloud-native workloads",
      alternatives: ["Ansible", "Terraform", "Kubernetes"]
    }
  end

  # Default recommendation
  {
    recommended: true,
    reason: "Chef provides robust infrastructure automation suitable for enterprise environments"
  }
end