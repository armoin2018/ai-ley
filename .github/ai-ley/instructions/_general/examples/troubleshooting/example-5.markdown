# TRACE Debugging Methodology

## T - Track the Problem
- **Reproduce**: Can you consistently reproduce the issue?
- **Environment**: What environment(s) does this occur in?
- **Timing**: When did this start? Is it constant or intermittent?
- **Scope**: Who/what is affected? What works correctly?

## R - Research and Gather Information
- **Logs**: Check application, system, and error logs
- **Metrics**: Review performance and resource utilization
- **Recent Changes**: What changed recently? (deployments, config, etc.)
- **External Factors**: Network issues, third-party service problems?

## A - Analyze the Data
- **Patterns**: Are there patterns in the failures?
- **Correlations**: Do errors correlate with specific conditions?
- **Timeline**: Map events chronologically
- **Dependencies**: What systems/services are involved?

## C - Create Hypotheses
- **Root Cause Theories**: What could be causing this?
- **Testable Hypotheses**: Form specific, testable theories
- **Prioritization**: Order hypotheses by likelihood and impact
- **Test Plan**: How will you test each hypothesis?

## E - Execute Tests and Evaluate
- **Controlled Testing**: Test one hypothesis at a time
- **Measure Results**: Did the test confirm or refute the hypothesis?
- **Document Findings**: Record what you learned
- **Iterate**: Refine hypotheses based on results