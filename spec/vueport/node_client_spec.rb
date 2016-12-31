require 'spec_helper'

describe Vueport::NodeClient do
  describe '#run!' do
    let(:content) { '<content>' }
    subject { described_class.new(content) }
    let(:url_matcher) { %r{http://localhost:5000/.*} }

    context 'when node renders successfully' do
      let!(:node_server) { stub_request(:post, url_matcher).to_return body: content, status: 200 }

      it 'runs the node command' do
        subject.run!
        expect(node_server).to have_been_requested
      end
    end

    context 'when node throws an error' do
      let(:error) { 'error' }
      let!(:node_server) { stub_request(:post, url_matcher).to_return body: error, status: 500 }

      it 'raises' do
        expect { subject.run! }.to raise_error(Vueport::RenderError, error)
        expect(node_server).to have_been_requested
      end
    end
  end
end
