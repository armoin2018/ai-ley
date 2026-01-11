# Detect circular dependencies
npm install --save-dev circular-dependency-plugin

# In rollup config
import circularDependency from 'rollup-plugin-circular-dependency'

export default {
  plugins: [
    circularDependency({
      failOnCircular: true,
      skipExternal: true
    })
  ]
}