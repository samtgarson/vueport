module Vueport
  class InstallGenerator < ::Rails::Generators::Base
    source_root File.expand_path('../template', __FILE__)

    desc 'Install extras for using Vue with WebpackRails'

    def add_webpack_rails
      gem 'webpack-rails'
      gem 'foreman'
    end

    def add_to_gitignore
      append_to_file '.gitignore' do
        <<-EOF.strip_heredoc
        # Added by vueport
        /node_modules
        /public/webpack
        /npm-debug.log

        /renderer/node_modules
        /renderer/npm-debug.log
        EOF
      end
    end

    def copy_package_json
      copy_file 'package.json'
    end

    def copy_eslint
      copy_file '.eslintrc.js'
      copy_file '.eslintignore'
    end

    def copy_config_files
      directory 'vueport', 'config/vueport'
    end

    def copy_renderer_files
      directory 'renderer'
    end

    def update_procfile
      copy_file 'Procfile.dev'
      copy_file 'Procfile'
    end

    def create_setup_files
      directory 'webpack'
      copy_file '.babelrc'
      empty_directory 'app/components'
    end

    def run_npm_install
      if yarn? && yes?("Would you like me to run 'yarn' for you? [y/N]")
        run 'yarn'
      elsif !yarn? && yes?("Would you like me to run 'npm install' for you? [y/N]")
        run 'npm install'
      end
    end

    def run_bundle_install
      run 'bundle install' if yes?("Would you like me to run 'bundle install' for you? [y/N]")
    end

    def whats_next
      say ""
      say 'All done!', :green

      say ""
      say "I've added a few things here and there to set you up using Vue in your Rails app."
      say "Now you're already to create your first Vue component in app/components."
      say ""

      say "To run the webpack-dev-server and rails server:"
      say 'foreman start -f Procfile.dev', :yellow
      say ""

      say "For more info, see the README.md for this gem at:"
      say "https://github.com/samtgarson/vueport", :blue
      say ""

      say "Thanks for using Vueport!"
    end

    private

      def yarn?
        @yarn ||= `yarn -V`.present?
      end
  end
end
