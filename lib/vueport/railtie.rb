require 'rails'
require 'rails/railtie'

module Vueport
  # :nodoc:
  class Railtie < ::Rails::Railtie
    config.vueport = ActiveSupport::OrderedOptions.new
    config.vueport.server_config_file = 'config/webpack.server.js'
    config.vueport.ssr_enabled = ::Rails.env.production?

    rake_tasks do
      load 'tasks/vueport.rake'
    end
  end
end
