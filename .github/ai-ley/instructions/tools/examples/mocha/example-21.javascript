const testCases = [
  { input: [1, 2], expected: 3 },
  { input: [5, 7], expected: 12 },
  { input: [-1, 1], expected: 0 },
  { input: [0, 0], expected: 0 },
];

describe('Calculator Addition', function () {
  testCases.forEach(({ input, expected }) => {
    it(`should add ${input[0]} + ${input[1]} = ${expected}`, function () {
      const calc = new Calculator();
      expect(calc.add(...input)).to.equal(expected);
    });
  });
});