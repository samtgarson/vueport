module.exports = {
  root: true,
  parser: 'babel-eslint',
  parserOptions: {
    sourceType: 'module'
  },
  extends: 'airbnb-base',
  // required to lint *.vue files
  plugins: [
    'html'
  ],
  // check if imports actually resolve
  'settings': {
    'import/resolver': {
      'webpack': {
        'config': '../config/vueport/webpack.base.conf.js'
      }
    }
  },
  // add your custom rules here
  'rules': {
    // allow debugger during development
    'comma-dangle': ['error', 'never'],
    'space-before-function-paren': ['error', 'always'],
    'semi': ['error', 'never'],
    'no-debugger': process.env.NODE_ENV === 'production' ? 2 : 0
  }
}
