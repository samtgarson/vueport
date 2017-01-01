const app = require('express')()
const fs = require('fs')
const path = require('path')
const bodyParser = require('body-parser')
const vueServerRenderer = require('vue-server-renderer')
const morgan = require('morgan')

const filePath = path.join(__dirname, './bundle.server.js')
const code = fs.readFileSync(filePath, 'utf8')
const bundleRenderer = vueServerRenderer.createBundleRenderer(code)

const PORT = process.env.PORT || 5000

app.use(bodyParser.text())
app.use(morgan('tiny'))

const render = html => new Promise((resolve, reject) => {
  bundleRenderer.renderToString({ body: html }, (err, res) => {
    if (err) return reject(err)
    return resolve(res)
  })
})

app.post('*', (req, res) => {
  if (typeof req.body !== 'string' || req.body.length === 0) return res.status(400).send('')
  return render(req.body)
    .catch((err) => {
      console.error(err)
      res.status(500).send(JSON.stringify(err))
    })
    .then(html => res.send(html))
})

app.listen(PORT, () => console.log('listening on', PORT))
