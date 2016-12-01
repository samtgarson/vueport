module Vueport
  class InstallGenerator < ::Rails::Generators::Base
    source_root File.expand_path('../../../../example', __FILE__)
    desc 'Install extras for using Vue with WebpackRails'

    def add_webpack_rails
      gem 'webpack-rails'
    end

    def bundle_and_install_webpack
      run 'gem install webpack-rails'
      generate 'webpack_rails:install'
    end

    def add_to_gitignore
      append_to_file '.gitignore' do
        <<-EOF.strip_heredoc
        npm-debug.log
        EOF
      end
    end

    def insert_resolve
      inject_into_file 'config/webpack.config.js', after: "root: path.join(__dirname, '..', 'webpack')" do
        <<~HEREDOC
        ,
            extensions: ['', '.js', '.vue'],
            fallback: [path.join(__dirname, '../node_modules'), path.join(__dirname, '../app/'),],
            alias: {
              // Use the standalone build to compile our page at runtime
              'vue$': 'vue/dist/vue.common.js'
            }
        HEREDOC
      end
    end

    def insert_module
      inject_into_file 'config/webpack.config.js', after: "assets: true\n    })]" do
        <<~HEREDOC
        ,
            // Use the necessary loaders to process our components
            module: {
              loaders: [
                {
                  test: /\.vue$/,
                  loader: 'vue'
                },
                {
                  loaders: ['babel'],
                  test: /\.js$/,
                  exclude: /node_modules/
                },
                {
                  test: /\.css$/,
                  loader: production ? ExtractTextPlugin.extract('vue-style', 'css') : 'style!css',
                  fallbackLoader: 'vue-style-loader'
                }
              ]
            },
            vue: {
              loaders: {
                css: production ? ExtractTextPlugin.extract('vue-style', "css") : 'style!css'
              }
            }
      HEREDOC
      end
    end

    def update_procfile
      remove_file 'Procfile'
      copy_file 'example/Procfile.dev', 'Procfile.dev'
      copy_file 'example/Procfile.prod', 'Procfile.prod'
    end

    def insert_css_extract
      inject_into_file 'config/webpack.config.js', after: "var StatsPlugin = require('stats-webpack-plugin');" do
        <<~HEREDOC

          var ExtractTextPlugin = require("extract-text-webpack-plugin");
        HEREDOC
      end

      inject_into_file 'config/webpack.config.js', after: 'new webpack.optimize.OccurenceOrderPlugin()' do
        <<~HEREDOC
        ,
            new ExtractTextPlugin("application.css")
      HEREDOC
      end
    end

    def update_dev_tool
      gsub_file 'config/webpack.config.js', 'cheap-module-eval-source-map', '#eval-source-map'
    end

    def create_server_config
      copy_file 'webpack.server.js', 'config/webpack.server.js'
    end

    def create_setup_files
      remove_file 'webpack/application.js'
      copy_file 'application.js', 'webpack/application.js'
      copy_file 'setup.js', 'webpack/setup.js'
      copy_file 'server.js', 'webpack/server.js'
      copy_file 'index.js', 'index.js'
      copy_file 'babelrc', '.babelrc'
      empty_directory 'app/components'
    end

    def add_npm_scripts
      inject_into_file 'package.json', before: '"dependencies": {' do
        <<~HEREDOC
        "scripts": {
            "dev-server": "./node_modules/.bin/webpack-dev-server --hot --inline --config config/webpack.config.js --host 0.0.0.0",
            "start": "NODE_ENV=production node ."
          },

      HEREDOC
      end
    end

    def add_npm_dependencies
      inject_into_file 'package.json', after: '"webpack-dev-server": "^1.9.0"' do
        <<~HEREDOC
        ,
            "body-parser": "^1.15.2",
            "express": "^4.14.0",
            "morgan": "^1.7.0",
            "extract-text-webpack-plugin": "^1.0.1",
            "vue": "^2.1.3",
            "vue-server-renderer": "^2.1.3",
            "babel-core": "^6.17.0",
            "babel-loader": "^6.2.5",
            "babel-polyfill": "^6.16.0",
            "babel-preset-es2015": "^6.16.0",
            "babel-preset-stage-0": "^6.16.0",
            "css-loader": "^0.25.0",
            "style-loader": "^0.13.1",
            "vue-loader": "^10.0.1",
            "vue-style-loader": "^1.0.0",
            "vue-template-compiler": "^2.1.3"
      HEREDOC
      end
    end

    def run_npm_install
      run 'npm install' if yes?("Would you like me to run 'npm install' for you (I've added a few things since last time?) [y/N]")
    end

    def whats_next
      # rubocop:disable Rails/Output
      puts <<-EOF.strip_heredoc

        I've added a few things here and there to set you up using Vue in your Rails app.

        Now you're already to create your first Vue component in app/components.
        Run 'foreman start' to run the webpack-dev-server and rails server.

        See the README.md for this gem at
        https://github.com/samtgarson/vueport
        for more info.
        Thanks for using Vueport!
      EOF
      # rubocop:enable Rails/Output
    end
  end
end
