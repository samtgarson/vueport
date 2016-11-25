import 'babel-polyfill'
import setup from './setup'

window.vm = setup(document.getElementById('vueport-wrapper').outerHTML)
vm.$mount('#vueport-wrapper')
if (module.hot) module.hot.accept(); // Enable Webpack HMR
