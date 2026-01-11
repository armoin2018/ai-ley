// .pnp.cjs usage
const pnp = require('./.pnp.cjs');

// ESM support in package.json
{
  "type": "module",
  "imports": {
    "#lib/*": "./lib/*"
  }
}