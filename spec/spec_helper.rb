$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'bundler'
require 'action_view'
require 'vueport'
require 'webmock/rspec'

WebMock.disable_net_connect!
Bundler.require :default, :development, :test
