require 'spec_helper'

describe Vueport::Helper do
  include ActionView::Helpers
  include ActionView::Context
  include described_class

  describe 'vueport' do
    let(:content) { 'content' }
    let(:renderer) { instance_double('Renderer', render: 'result') }

    before do
      allow(renderer).to receive(:render)
    end

    it 'it accepts and renders a block' do
      expect(Vueport::Renderer).to receive(:new).with(content).and_return(renderer)

      vueport { content }
    end

    it 'it accepts and renders a block' do
      expect(Vueport::Renderer).to receive(:new).with(content).and_return(renderer)

      vueport(content)
    end
  end
end
