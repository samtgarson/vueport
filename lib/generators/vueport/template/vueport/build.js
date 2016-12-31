// https://github.com/shelljs/shelljs
require('shelljs/global')
env.NODE_ENV = 'production'

var path = require('path')
var config = require('./config')
var ora = require('ora')
var webpack = require('webpack')
var clientConfig = require('./webpack.prod.conf')
var serverConfig = require('./webpack.server.conf')

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

const compile = (config, bundle) => {
  const spinner = ora(`Building ${bundle} for production...`)
  spinner.start()

  return new Promise(function (resolve, reject) {
    webpack(config, function (err, stats) {
      if (err) {
        spinner.text = `Error building ${bundle}.`
        spinner.fail()
        return reject(err)
      }

      spinner.text = `Built ${bundle} successfully`
      spinner.succeed()
      process.stdout.write(stats.toString(statsConfig) + '\n')
      resolve()
    })
  })
}

compile(clientConfig, 'client bundle').then(() => { 
  compile(serverConfig, 'server bundle') 
})
