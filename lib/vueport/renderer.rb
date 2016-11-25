module Vueport
  class Renderer
    WRAPPER_ID = 'vueport-wrapper'.freeze
    
    def initialize(content)
      @content = content
    end

    def render
      "<div id='#{WRAPPER_ID}'>#{rendered_content}</div>".html_safe
    end

    private

      def rendered_content
        @content
      end
  end
end
