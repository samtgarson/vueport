module Vueport
  class Renderer
    include ActionView::Helpers::TagHelper

    CONTENT_WRAPPER_ID = 'vueport-wrapper'.freeze
    TEMPLATE_ID = 'vueport-template'.freeze

    attr_accessor :content

    def initialize(content)
      self.content = content
    end

    def render
      safe_join [rendered_content, template]
    end

    private

      def rendered_content
        ssr_enabled? ? ssr_content : wrapped_content
      end

      def template
        content_tag :script, wrapped_content, type: 'text/x-template', id: TEMPLATE_ID
      end

      def ssr_content
        Vueport::NodeClient.new(wrapped_content).run!
      rescue Vueport::RenderError
        content_tag :div, '', id: CONTENT_WRAPPER_ID
      end

      def wrapped_content
        content_tag :div, content, id: CONTENT_WRAPPER_ID
      end

      def ssr_enabled?
        ::Rails.configuration.vueport.ssr_enabled
      end
  end
end
