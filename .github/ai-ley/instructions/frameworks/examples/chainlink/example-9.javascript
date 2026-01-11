// functions/source.js - Functions source code
const source = `
// Fetch data from external API
const url = 'https://api.coinbase.com/v2/exchange-rates?currency=BTC';

try {
  const response = await Functions.makeHttpRequest({
    url: url,
    method: "GET",
    headers: {
      "Authorization": \`Bearer \${secrets.apiKey}\`
    }
  });

  if (response.error) {
    throw new Error(\`API Error: \${response.error}\`);
  }

  const data = response.data;
  const btcPrice = parseFloat(data.data.rates.USD);
  
  // Return price as bytes32
  return Functions.encodeUint256(Math.round(btcPrice * 1e8));
} catch (error) {
  throw new Error(\`Request failed: \${error.message}\`);
}
`;

// functions/config.js - Function configuration
const functionsConfig = {
  source: source,
  secrets: { apiKey: process.env.COINBASE_API_KEY },
  args: [],
  expectedReturnType: "uint256",
  subscriptionId: process.env.FUNCTIONS_SUBSCRIPTION_ID
};

module.exports = { functionsConfig };