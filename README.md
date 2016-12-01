# Vueport
>Single file components and SSR for Rails with Vue JS and Webpack

[![CircleCI](https://img.shields.io/circleci/project/github/samtgarson/vueport.svg)](https://circleci.com/gh/samtgarson/vueport) [![Gem Version](https://img.shields.io/gem/v/vueport.svg)](https://rubygems.org/gems/vueport) [![Gem Downloads](https://img.shields.io/gem/dt/vueport.svg)](https://rubygems.org/gems/vueport)

Vueport provides your Rails app with a modern, componentized approach to UI development by using Webpack and Vue.js to enable single file, reactive components rendered on the server and the client and seamless integration with your Rails views.

Take a look at the Vue.js [documentation on single file components](https://vuejs.org/guide/single-file-components.html) for more information on that side of things.

Vueport piggybacks onto the [WebpackRails gem](https://github.com/mipearson/webpack-rails) to get Webpack setup with Rails, so check that out for more information.

## Example Rails App

[Here](https://github.com/samtgarson/vueport-example).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'vueport'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install vueport

Then just run 

```shell
rails generate vueport:install
```

to bootstrap everything you need to get started (this will install WebpackRails and also everything Vueport needs on top).

To run your app, execute

```shell
bundle exec foreman start -f Procfile.dev
```

to boot the Webpack Dev server and your Rails app!

## Production Deployment

Ensure to run `rails vueport:compile` as part of your deployment process to production. This compiles the production version of your client side bundle, as well as compiling the server side bundle for our Node JS app to use.

In production we send HTTP requests to a basic NodeJS server to render our content. To run the Rails app and the Node server concurrently, use `Procfile`.

## Usage

### View Helper

Wrap your application in the `vueport` helper, to render out your components. E.g. in your `application.html.erb`:

```erb
<body>
    <%= vueport do %>
        <%= render partial: 'shared/nav' %>
        <%= yield %>
    <% end %>
</body>
```

It can also accept a single argument. E.g.:

```erb
<body>
    <%= vueport yield %>
</body>
```

### Asset Setup

Add the Webpack Rails helpers to your layout to include your Javascript and CSS (see the [WebpackRails readme](https://github.com/mipearson/webpack-rails) for more information).

**Ensure you place the JS entrypoint after the Vueport helper!**

E.g.:

```erb
<head>
    <%= stylesheet_link_tag *webpack_asset_paths('application', extension:  'css') %>
</head>
<body>
    <%= vueport do %>
        <%= render partial: 'shared/nav' %>
        <%= yield %>
    <% end %>

    <%= javascript_include_tag *webpack_asset_paths("application", extension: 'js') %>
</body>
```

### Default config

Out of the box, Vueport expects your components to live in _app/components_, and compiles assets to _public/webpack_. To change these, you'll need to change both the Webpack config (in _config/webpack.config.js_ and _config/webpack.server.js_) and the Vue gem application config. To do this, in an initializer do:

```ruby
Vueport.configure do |config|
    config[:server_port] = 3001
end
```

_Check out the WebpackRails gem for information on its configuration._

## How does it work?

To see how WebpackRails works, take a look at [this section of the readme](https://github.com/mipearson/webpack-rails#how-it-works).

Vueport extends the functionality of WebpackRails by adding a few extra features:

- Webpack setup to read and compile Vue components
- Webpack setup to enable HMR (Hot Module Reloading) for an A+ development experience
- Server Side rendering in production.

### Server Side Rendering (SSR)

To enable Server Side rendering, I created a simple NodeJS app which uses the [Vue Server Renderer](https://www.npmjs.com/package/vue-server-renderer) to render out the contents of the page on each request. To enable Client Side rehydration, we also attach the original view contents in a template for the Client Side Vue instance to pick up.

SSR is only enabled in production.

## Why Vue.js?

My experience of working with many modern UI libraries, and particulary with integrating them with Rails apps (especially React and Vue JS), has lead me to the conclusion that Vue JS seems to be a more explcit and 'batteries included' library when building compnents for Rails. 

I use React on a regular basis for SPAs and love its functional philosophy, but for writing components to fit into a Rails frontend, Vue seems to provide me with the least complexity, and seems to be easiest for Ruby developers to reason about.

For a Vue.js and React [collaborative](https://github.com/vuejs/vuejs.org/issues/364) comparison, [check this out](https://vuejs.org/guide/comparison.html).

## To Do

- [x] Handle SSR
- [ ] Make webpack config more like the config from the [Vue CLI template](https://github.com/vuejs-templates/webpack/tree/master/template/build)
- [ ] Optimize SSR interaction with NodeJS
- [ ] JS Component test setup

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/samtgarson/vueport. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Thanks

- Many thanks to [Evan You](https://github.com/yyx990803) and the VueJS for sustaining such a vibrant and supporting community around Vue JS
- Many thanks also to [mipearson](https://github.com/mipearson) for his WebpackRails gem which this gem completely cannibalizes

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

