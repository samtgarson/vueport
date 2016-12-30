import Vue from 'vue'
// Import your components here, then include it in your Vue application below.
// (We've added /app to our webpack resolves for convenience)

// import MyComponent from 'components/my-component'

export default function (template) {
  return new Vue({
    template: template,
    components: {
      //MyComponent
    }
  })
}
