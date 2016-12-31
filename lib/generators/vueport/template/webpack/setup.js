import Vue from 'vue'
/*
*  Import your components here.
*  Your components directory is aliased as 'components'
*  e.g.
*
import MyComponent from 'components/my-component'
*/

export default function (template) {
  return new Vue({
    template,
    // Then include them here:
    components: {
      // MyComponent
    }
  })
}
