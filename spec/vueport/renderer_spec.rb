require 'spec_helper'

describe Vueport::Renderer do
  describe '#render' do
    let(:content) { 'content' }
    subject { described_class.new(content) }

    context 'without SSR' do
      before do
        allow(subject).to receive(:ssr_enabled?).and_return false
      end

      it 'renders and wraps the content' do
        expect(subject.render).to eql "<div id='#{described_class::WRAPPER_ID}'>#{content}</div>"
      end
    end

    context 'with SSR' do
      let(:rendered_content) { 'rendered' }

      let(:node_client) { instance_double('Vueport::NodeClient', run!: rendered_content) }

      before do
        allow(subject).to receive(:ssr_enabled?).and_return true
        allow(Vueport::NodeClient).to receive(:new).and_return(node_client)
      end

      context 'and everything runs smoothly' do
        it 'renders and wraps the content' do
          expect(subject.render).to eql rendered_content
        end
      end

      context 'and node throws an error' do
        before do
          allow(node_client).to receive(:run!).and_raise(Vueport::RenderError)
        end

        it 'returns unrendered content' do
          expect(subject.render).to eql "<div id='#{described_class::WRAPPER_ID}'>#{content}</div>"
        end
      end
    end
  end
end
