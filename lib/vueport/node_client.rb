module Vueport
  class RenderError < StandardError; end

  class NodeClient
    attr_accessor :content, :path

    def initialize(content, path: '/')
      self.content = content
      self.path = path
    end

    def run!
      render.force_encoding('UTF-8').encode!.html_safe
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
        @response ||= http.tap { |http| http.read_timeout = 3 }.post path, content, 'Content-Type' => 'text/plain'
      end

      def http
        @http ||= Net::HTTP.new Vueport.config[:server_host], Vueport.config[:server_port]
      end
  end
end
