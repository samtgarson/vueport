require 'spec_helper'

shared_examples_for 'a basic renderer' do
  it 'serves an empty wrapper' do
    expect(subject.render).to have_tag wrapper_selector, text: ''
  end

  it 'serves the original template' do
    expect_to_contain_original_template
  end
end

describe Vueport::Renderer do
  include RSpecHtmlMatchers

  describe '#render' do
    let(:content) { 'content' }
    let(:wrapper_selector) { "div##{described_class::CONTENT_WRAPPER_ID}" }
    subject { described_class.new(content) }

    context 'without SSR' do
      before do
        Vueport.configure { |c| c[:ssr_enabled] = false }
      end

      it_behaves_like 'a basic renderer'
    end

    context 'with SSR' do
      let(:rendered_content) { 'rendered' }

      let(:node_client) { instance_double('Vueport::NodeClient', run!: rendered_content) }

      before do
        allow(Vueport::NodeClient).to receive(:new).and_return(node_client)
        Vueport.configure { |c| c[:ssr_enabled] = true }
      end

      context 'and everything runs smoothly' do
        it 'renders the content' do
          expect(subject.render).to match(/^#{rendered_content}/)
        end

        it 'serves the original template' do
          expect_to_contain_original_template
        end
      end

      context 'and node throws an error' do
        before do
          allow(node_client).to receive(:run!).and_raise(Vueport::RenderError)
        end

        it_behaves_like 'a basic renderer'
      end
    end
  end

  def expect_to_contain_original_template
    render = subject.render
    expect(render).to have_tag "script##{described_class::TEMPLATE_ID}"
    expect(render).to include described_class::CONTENT_WRAPPER_ID
    expect(render).to include content
  end
end
