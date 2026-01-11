// test/reporters/custom-reporter.js
const { Base } = require('mocha').reporters;

function CustomReporter(runner) {
  Base.call(this, runner);

  runner.on('start', function () {
    console.log('🚀 Starting test suite...');
  });

  runner.on('pass', function (test) {
    console.log(`✅ ${test.title}`);
  });

  runner.on('fail', function (test, err) {
    console.log(`❌ ${test.title}: ${err.message}`);
  });

  runner.on('end', function () {
    console.log(
      `🏁 Tests completed: ${runner.stats.passes} passed, ${runner.stats.failures} failed`,
    );
  });
}

module.exports = CustomReporter;