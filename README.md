# Vueport
>Single file components for Rails with Vue JS and Webpack

[![CircleCI](https://circleci.com/gh/samtgarson/vueport.svg?style=svg)](https://circleci.com/gh/samtgarson/vueport)

Vueport provides your Rails app with a modern, componentized approach to UI development by using Webpack and Vue.js to enable single file, reactive components rendered on the server and the client and seamless integration with your Rails views.

Take a look at the Vue.js [documentation on single file components](https://vuejs.org/guide/single-file-components.html) for more information on that side of things.

⚠️ Not yet released, still under active development! ⚠️

## Example

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


## Why Vue.js?

My experience of working with many modern UI libraries, and particulary with integrating them with Rails apps (particularly React and Vue JS), has lead me to the conclusion that Vue JS seems to be a more explcit and 'batteries included' library when building compnents for Rails. 

I use React on a regular basis for SPAs and love its functional philosophy, but for writing components to fit into a Rails frontend, Vue seems to provide me with the least complexity, and seems to be easiest for other Ruby developers to reason about.

For a Vue.js and React [collaborative](https://github.com/vuejs/vuejs.org/issues/364) comparison, [check this out](https://vuejs.org/guide/comparison.html).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/samtgarson/vueport. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

