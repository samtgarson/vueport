require 'spec_helper'
require 'httparty'

describe Vueport::NodeClient do
  describe '#run!' do
    let(:content) { '<content>' }
    subject { described_class.new(content) }

    context 'and node renders successfully' do
      let(:response) { double('HTTParty::Response', code: 200, body: content) }

      it 'runs the node command' do
        expect(HTTParty).to receive(:post).and_return response
        subject.run!
      end
    end

    context 'and node throws an error' do
      let(:error) { 'error' }
      let(:response) { double('HTTParty::Response', code: 500, body: error) }

      before { allow(HTTParty).to receive(:post).and_return response }

      it 'raises' do
        expect { subject.run! }.to raise_error(Vueport::RenderError, error)
      end
    end
  end
end
