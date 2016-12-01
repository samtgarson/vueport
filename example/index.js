const app = require('express')()
const fs = require('fs');
const path = require('path');
const bodyParser = require('body-parser')
const vueServerRenderer = require('vue-server-renderer');
const morgan = require('morgan')

const filePath = path.join(__dirname, './public/webpack/bundle.server.js')
const code = fs.readFileSync(filePath, 'utf8');
const bundleRenderer = vueServerRenderer.createBundleRenderer(code);

const PORT = process.env['PORT'] || 5000

app.use(bodyParser.text())
app.use(morgan('tiny'))

const render = html => {
  return p = new Promise((resolve, reject) => {
    bundleRenderer.renderToString({body: html}, (err, html) => {
      if (err) return reject(err)
      else return resolve(html)
    })
  })
}

app.post('/render', (req, res) => {
  render(req.body)
    .catch(err => {
      console.error(err)
      res.status(500).send(JSON.stringify(err))
    })
    .then(html => res.send(html))
})

app.listen(PORT, () => console.log('listening on', PORT))
