# Risk Assessment Template

## Risk Identification Matrix
| Risk ID | Risk Description | Category | Probability | Impact | Risk Score | Owner |
|---------|------------------|----------|-------------|--------|------------|--------|
| R001 | Third-party API changes | Technical | Medium | High | 15 | Tech Lead |
| R002 | Key developer unavailability | Resource | Low | High | 10 | PM |
| R003 | Scope creep from stakeholders | Scope | High | Medium | 12 | PM |
| R004 | Integration complexity underestimated | Technical | Medium | Medium | 9 | Architect |

## Risk Categories
- **Technical**: Technology, architecture, integration risks
- **Resource**: Team availability, skill gaps, budget constraints
- **Scope**: Requirement changes, feature creep, unclear requirements
- **Schedule**: Dependencies, unrealistic timelines, external factors
- **Quality**: Performance, security, usability concerns

## Risk Response Strategies
### Risk R001: Third-party API Changes
- **Strategy**: Mitigate
- **Actions**: 
  - Create abstraction layer for API integration
  - Monitor API versioning and deprecation notices
  - Implement comprehensive integration tests
  - Maintain fallback options where possible
- **Contingency**: Have alternative API providers identified
- **Review Date**: Every sprint

### Risk R003: Scope Creep
- **Strategy**: Avoid
- **Actions**:
  - Implement formal change control process
  - Regular stakeholder alignment meetings
  - Clear documentation of what's in/out of scope
  - Time-boxed exploration for new requirements
- **Contingency**: Defer non-critical features to future releases
- **Review Date**: Weekly stakeholder check-ins