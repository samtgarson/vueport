import 'babel-polyfill'
import setup from './setup'

export default function (context) {
  const app = setup(context.body)
  return new Promise((resolve) => {
    resolve(app)
  })
}
