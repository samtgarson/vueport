module Vueport
  class Renderer
    WRAPPER_ID = 'vueport-wrapper'.freeze
    attr_accessor :content
    
    def initialize(content)
      self.content = content
    end

    def render
      rendered_content.html_safe
    end

    private

      def rendered_content
        ssr_enabled? ? ssr_content : wrapped_content
      end

      def ssr_content
        Vueport::NodeClient.new(wrapped_content).run!
      rescue Vueport::RenderError
        wrapped_content
      end

      def wrapped_content
        "<div id='#{WRAPPER_ID}'>#{content}</div>"
      end

      def ssr_enabled?
        ::Rails.configuration.vueport.ssr_enabled
      end
  end
end
