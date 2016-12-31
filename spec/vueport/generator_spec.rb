require 'spec_helper'
require 'rails/generators'
require 'action_controller'
require 'generators/vueport/install_generator'
require 'ammeter/init'
require 'fileutils'

RSpec.describe Vueport::InstallGenerator, type: :generator do
  destination File.expand_path('../../../tmp/example', __FILE__)
  let(:files) { %w(package.json .eslintrc.js .eslintignore Procfile.dev Procfile .babelrc) }
  let(:dirs) { %w(webpack app/components renderer config/vueport) }

  before do
    prepare_destination
    copy_example_files
    set_shell_prompt_responses generator, yes?: false
    run_generator
  end

  after(:all) do
    FileUtils.rm_rf 'tmp/example'
  end

  it 'installs the correct gems' do
    gemfile = file 'Gemfile'
    expect(gemfile).to contain(/gem 'webpack-rails'/)
    expect(gemfile).to contain(/gem 'foreman'/)
  end

  it 'appends to the gitignore' do
    expect(file '.gitignore').to contain(/# Added by vueport/)
  end

  it 'copies all the root files' do
    files.each do |f|
      expect(file f).to exist
    end
  end

  it 'copies the directories' do
    dirs.each do |f|
      expect(file f).to exist
    end
  end

  def copy_example_files
    FileUtils.cp_r 'spec/example', 'tmp/'
  end
end
