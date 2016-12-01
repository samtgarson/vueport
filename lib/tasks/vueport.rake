namespace :vueport do
  desc 'Compile client and server bundles'
  task compile: :environment do
    ENV['NODE_ENV'] = 'production'
    webpack_bin = ::Rails.root.join(::Rails.configuration.webpack.binary)
    config_file = ::Rails.root.join(::Rails.configuration.webpack.config_file)
    server_config_file = ::Rails.root.join(Vueport.config[:server_config_file])

    unless File.exist?(webpack_bin)
      raise "Can't find our webpack executable at #{webpack_bin} - have you run `npm install`?"
    end

    unless File.exist?(config_file)
      raise "Can't find our webpack config file at #{config_file}"
    end

    unless File.exist?(server_config_file)
      raise "Can't find our webpack server config file at #{config_file}"
    end

    sh "#{webpack_bin} --config #{config_file} --bail"
    sh "#{webpack_bin} --config #{server_config_file} --bail"
  end
end
