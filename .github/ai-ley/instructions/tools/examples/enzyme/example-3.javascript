import React from 'react';
import { shallow, mount } from 'enzyme';
import { axe } from 'jest-axe';
import { SecurityTestUtils } from '../utils/SecurityTestUtils';

import MyComponent from '../MyComponent';

describe('MyComponent - Enterprise Tests', () => {
  // Security testing
  it('should prevent XSS attacks', () => {
    const results = SecurityTestUtils.testXSSVulnerability(
      MyComponent,
      {},
      global.TestUtils.security.xssPayloads,
    );

    expect(results.filter((r) => r.vulnerability === 'XSS')).toHaveLength(0);
  });

  // Accessibility testing
  it('should have no accessibility violations', async () => {
    const wrapper = mount(<MyComponent />);
    const results = await axe(wrapper.getDOMNode());
    expect(results).toHaveNoViolations();
    wrapper.unmount();
  });

  // Performance testing
  it('should render within performance budget', () => {
    const performanceResults = PerformanceTestUtils.measureRenderPerformance(
      MyComponent,
      {},
      { iterations: 5 },
    );

    expect(performanceResults.render.average).toBeLessThan(50);
  });
});