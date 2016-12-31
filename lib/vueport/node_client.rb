module Vueport
  class RenderError < StandardError; end

  class NodeClient
    attr_accessor :content

    def initialize(content)
      self.content = content
    end

    def run!
      render.html_safe
    end

    private

      def render
        case response
        when Net::HTTPSuccess
          response.body
        else
          raise(RenderError.new, response.body)
        end
      end

      def response
        @response ||= http.post '/render', content, 'Content-Type' => 'text/plain'
      end

      def http
        @http ||= Net::HTTP.new Vueport.config[:server_host], Vueport.config[:server_port]
      end
  end
end
