require 'spec_helper'
require 'open3'

describe Vueport::NodeClient do
  describe '#run!' do
    let(:content) { '<content>' }
    subject { described_class.new(content) }

    it 'runs the node command' do
      expect(Open3).to receive(:popen3).with('node . --html \\<content\\>')
      subject.run!
    end

    let(:error) { 'error' }
    let(:wait_stub) { double(value: double(success?: false)) }
    let(:error_stub) { double(read: error) }

    it 'raises if an error occurs' do
      allow(Open3).to receive(:popen3).and_yield(nil, nil, error_stub, wait_stub)
      expect { subject.run! }.to raise_error(Vueport::RenderError, error)
    end
  end
end
