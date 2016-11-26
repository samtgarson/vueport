import 'babel-polyfill'
import setup from './setup'

window.vm = setup('#vueport-template')
vm.$mount('#vueport-wrapper')
