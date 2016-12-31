// https://github.com/shelljs/shelljs
require('shelljs/global')
env.NODE_ENV = 'production'

var path = require('path')
var config = require('./config')
var ora = require('ora')
var webpack = require('webpack')
var clientConfig = require('./webpack.prod.conf')
var serverConfig = require('./webpack.server.conf')

var spinner = ora('building client bundle for production...')
spinner.start()

var assetsPath = path.join(config.build.assetsRoot)
rm('-rf', assetsPath)
mkdir('-p', assetsPath)

var statsConfig = {
  colors: true,
  modules: false,
  children: false,
  chunks: false,
  chunkModules: false
}

webpack(clientConfig, function (err, stats) {
  spinner.stop()
  if (err) throw err
  process.stdout.write(stats.toString(statsConfig) + '\n')
})

var spinner = ora('building server bundle for production...')
spinner.start()

webpack(serverConfig, function (err, stats) {
  spinner.stop()
  if (err) throw err
  process.stdout.write(stats.toString(statsConfig) + '\n')
})
