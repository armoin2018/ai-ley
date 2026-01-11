'*.js': (filenames) => {
  const testFiles = filenames.filter(f => f.includes('.test.'));
  const sourceFiles = filenames.filter(f => !f.includes('.test.'));

  const commands = [];
  if (sourceFiles.length > 0) {
    commands.push(`eslint --fix ${sourceFiles.join(' ')}`);
  }
  if (testFiles.length > 0) {
    commands.push(`jest --bail ${testFiles.join(' ')}`);
  }

  return commands;
}