var path = require('path')
var utils = require('./utils')
var webpack = require('webpack')
var merge = require('webpack-merge')
var baseWebpackConfig = require('./webpack.base.conf')

baseWebpackConfig.plugins = []
delete baseWebpackConfig.resolve.alias['vue$']
var webpackConfig = merge(baseWebpackConfig, {
  entry: './webpack/server.js',
  module: {
    loaders: utils.styleLoaders({ sourceMap: false, extract: false })
  },
  target: 'node',
  output: {
    path: path.resolve(__dirname, '../../renderer'),
    libraryTarget: 'commonjs2',
    filename: 'bundle.server.js'
  },
  vue: {
    loaders: utils.cssLoaders({ 
      sourceMap: false, 
      extract: false 
    })
  },
  plugins: [
    // http://vuejs.github.io/vue-loader/en/workflow/production.html
    new webpack.DefinePlugin({
      'process.env': '"production"'
    }),
    new webpack.optimize.UglifyJsPlugin({
      compress: {
        warnings: false
      }
    }),
    new webpack.optimize.DedupePlugin(),
    new webpack.optimize.OccurrenceOrderPlugin(),
  ]
})

module.exports = webpackConfig
