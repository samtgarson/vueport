// Example webpack configuration with asset fingerprinting in production.
'use strict';

var path = require('path');
var webpack = require('webpack');

var config = {
  target: 'node', // !different
  entry: './webpack/server.js',
  output: {
    libraryTarget: 'commonjs2', // !different
    path: path.join(__dirname, '..', 'public', 'webpack'),
    publicPath: '/webpack/',
    filename: 'bundle.server.js',
  },
  resolve: {
    root: path.join(__dirname, '..', 'webpack'),
    extensions: ['', '.js', '.vue'],
    fallback: [path.join(__dirname, '../node_modules'), path.join(__dirname, '../app/'),]
  },

  plugins: [
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
  ],

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


module.exports = config;
