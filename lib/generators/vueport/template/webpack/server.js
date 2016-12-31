import 'babel-polyfill'
import Vue from 'vue'
import setup from './setup';

export default function(context) {
  const app = setup(context.body)
  return new Promise((resolve, reject) => {
    resolve(app);
  });
};
