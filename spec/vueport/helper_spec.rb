require 'spec_helper'

describe Vueport::Helper do
  include ActionView::Helpers
  include ActionView::Context
  include described_class

  describe 'vueport' do
    let(:content) { 'content' }
    let(:renderer) { instance_double('Renderer', render: 'result') }
    let(:request) { double('request', path: path) }
    let(:path) { '/test-path' }

    before do
      allow(described_class).to receive(:request).and_return(request)
    end

    it 'it accepts and renders a block' do
      expect(Vueport::Renderer).to receive(:new).with(content, path: path).and_return(renderer)

      vueport { content }
    end

    it 'it accepts and renders a argument' do
      expect(Vueport::Renderer).to receive(:new).with(content, path: path).and_return(renderer)

      vueport(content)
    end
  end
end
