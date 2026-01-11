// ✅ Good: Create promises for callback-based APIs
function readFileAsync(filename) {
  return new Promise((resolve, reject) => {
    fs.readFile(filename, 'utf8', (error, data) => {
      if (error) {
        reject(error);
      } else {
        resolve(data);
      }
    });
  });
}

// ✅ Good: Chain promises properly
function processData(input) {
  return validateInput(input)
    .then(transformData)
    .then(saveToDatabase)
    .then(sendNotification)
    .catch(handleError);
}