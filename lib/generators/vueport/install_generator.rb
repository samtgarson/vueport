module Vueport
  class InstallGenerator < ::Rails::Generators::Base
    source_root File.expand_path('../template', __FILE__)

    desc 'Install a local node rendering service for Vueport'

    def add_gems
      gem_group :development do
        gem 'foreman'
      end
    end

    def install_renderer
      plugin 'vue-renderer', :git => 'git://github.com/samtgarson/vue-renderer.git'
    end

    # rubocop:disable Metrics/MethodLength
    def whats_next
      say ''
      say 'All done!', :green

      say ''
      say "I've installed foreman and a vue-rendering service in a local git submodule"
      say ''

      say 'You\'ll need to run yarn from ./vue-renderer to install its dependencies:'
      say 'cd vueport-renderer && yarn', :yellow
      say ''

      say 'For more info, see the README.md for this gem at:'
      say 'https://github.com/samtgarson/vueport', :blue
      say ''

      say 'Thanks for using Vueport!'
    end
    # rubocop:enable Metrics/MethodLength

    private

      def yarn?
        @yarn ||= `yarn -V`.present?
      end
  end
end
