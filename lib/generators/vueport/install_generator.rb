module Vueport
  class InstallGenerator < ::Rails::Generators::Base
    source_root File.expand_path('../../../../example', __FILE__)
    desc 'Install extras for using Vue with WebpackRails'

    def add_webpack_rails
      gem 'webpack-rails'
      if (@foreman = yes?("Are you planning on using Foreman to run this app locally? [y/N]\n(If you're not sure and you're not using Docker Compose or similar, the answer is probably yes)"))
        gem 'foreman'
      else
    end

    def add_to_gitignore
      append_to_file '.gitignore' do
        <<-EOF.strip_heredoc
        # Added by vueport
        /node_modules
        /public/webpack
        /npm-debug.log

        renderer/node_modules
        renderer/npm-debug.log
        EOF
      end
    end

    def copy_package_json
      copy_file 'package.json'
    end

    def copy_eslint
      copy_file '.eslintrc.js'
      copy_file '.eslintrcignore'
    end

    def copy_config_files
      directory 'vueport', 'config/vueport'
    end

    def copy_config_files
      directory 'renderer'
    end

    def update_procfile
      copy_file 'Procfile.dev'
      copy_file 'Procfile'
    end

    def create_setup_files
      directory 'webpack'
      copy_file 'babelrc', '.babelrc'
      empty_directory 'app/components'
    end

    def run_npm_install
      if `yarn -V`.present?
        run 'yarn' if yes?("Would you like me to run 'yarn' for you? [y/N]")
      else
        run 'npm install' if yes?("Would you like me to run 'npm install' for you? [y/N]")
      end
    end

    def run_bundle_install
      run "bundle install" if yes?("Would you like me to run 'bundle install' for you? [y/N]")
    end

    def whats_next
      # rubocop:disable Rails/Output
      puts <<-EOF.strip_heredoc

        I've added a few things here and there to set you up using Vue in your Rails app.

        Now you're already to create your first Vue component in app/components.
        Run 'foreman start -f Procfile.dev' to run the webpack-dev-server and rails server.

        See the README.md for this gem at
        https://github.com/samtgarson/vueport
        for more info.
        Thanks for using Vueport!
      EOF
      # rubocop:enable Rails/Output
    end
  end
end
