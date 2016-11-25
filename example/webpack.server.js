// Example webpack configuration with asset fingerprinting in production.
'use strict';

var path = require('path');
var webpack = require('webpack');
var StatsPlugin = require('stats-webpack-plugin');

var config = {
  target: 'node', // !different
  entry: './webpack/server.js'
  output: {
    libraryTarget: 'commonjs2', // !different
    path: path.join(__dirname, '..', 'public', 'webpack'),
    publicPath: '/webpack/',
    filename: 'bundle.server.js',
  },

  plugins: [
    // must match config.webpack.manifest_filename
    new StatsPlugin('manifest.json', {
      // We only need assetsByChunkName
      chunkModules: false,
      source: false,
      chunks: false,
      modules: false,
      assets: true
    })
  ],
  resolve: {
    root: path.join(__dirname, '..', 'webpack'),
    extensions: ['', '.js', '.vue'],
    fallback: [path.join(__dirname, '../node_modules'), path.join(__dirname, '../app/'),],
    alias: {
      // Use the standalone build to compile our page at runtime
      'vue$': 'vue/dist/vue.common.js'
    }
  },

  module: {
    loaders: [
      {
        test: /\.vue$/,
        loader: 'vue'
      },
      {
        test: /\.json$/,
        loader: 'json'
      },
      {
        loaders: ['babel'],
        test: /\.js$/,
        exclude: /node_modules/
      },
      {
        test: /\.(sc|sa|c)ss$/,
        loaders: ['style', 'css', 'sass']
      }
    ]
  }
};

config.plugins.push(
  new webpack.NoErrorsPlugin(),
  new webpack.optimize.UglifyJsPlugin({
    compressor: { warnings: false },
    sourceMap: false
  }),
  new webpack.DefinePlugin({
    'process.env': { NODE_ENV: JSON.stringify('production') }
  }),
  new webpack.optimize.DedupePlugin(),
  new webpack.optimize.OccurenceOrderPlugin()
);

module.exports = config;
