require 'spec_helper'

RSpec.describe 'Rubocop' do
  let!(:files) do
    current_sha = `git rev-parse --verify HEAD`.strip!
    files = `git diff #{current_sha} --name-only | grep .rb | grep -v spec`
    files.tr!("\n", ' ')
  end

  context 'given the files that have changed' do
    subject(:report) { `bundle exec rubocop #{files}` }
    it 'checks that there are no syntax offenses' do
      expect(report.match('Offenses')).not_to be_truthy, -> { puts report }
    end
  end
end
