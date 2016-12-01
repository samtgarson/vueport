require 'httparty'

require 'vueport/helper'
require 'vueport/renderer'
require 'vueport/node_client'
require 'vueport/version'

module Vueport
  module_function

  def config
    @config ||= {
      server_host: 'localhost',
      server_port: 5000,
      server_config_file: 'config/webpack.server.js',
      ssr_enabled: false
    }
  end

  def configure(&_block)
    yield config if block_given?
  end
end

require 'vueport/railtie' if defined? ::Rails::Railtie
