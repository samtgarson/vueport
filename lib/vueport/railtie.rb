require 'rails'
require 'rails/railtie'
require 'vueport'

module Vueport
  # :nodoc:
  class Railtie < ::Rails::Railtie
    Vueport.configure do |config|
      config[:ssr_enabled] = ::Rails.env.production?
    end

    config.after_initialize do
      ActiveSupport.on_load(:action_view) do
        include Vueport::Helper
      end
    end
  end
end
