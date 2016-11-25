const fs = require('fs');
const path = require('path');
const vueServerRenderer = require('vue-server-renderer');
const parseArgs = require('minimist')

const filePath = path.join(__dirname, './public/webpack/bundle.server.js')
const code = fs.readFileSync(filePath, 'utf8');
const bundleRenderer = vueServerRenderer.createBundleRenderer(code);

const args = parseArgs(process.argv, {string: 'html'})

bundleRenderer.renderToString({body: args.html}, (err, html) => {
  if (err) console.err(err)
  else console.log(html)
})
