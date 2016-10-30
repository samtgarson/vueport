require 'spec_helper'

describe Vueport::Renderer do
  describe '#render' do
    let(:content) { 'content' }
    subject { described_class.new(content) }

    it 'renders and wraps the content' do
      expect(subject.render).to eql "<div id='#{described_class::WRAPPER_ID}'>#{content}</div>"
    end
  end
end
