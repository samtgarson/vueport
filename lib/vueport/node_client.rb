
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
        raise(RenderError.new, response.body) if response.code != 200
        response.body
      end

      def response
        @response ||= HTTParty.post("http://#{server_uri}/render", post_params)
      end

      def post_params
        {
          body: content,
          headers: {
            'Content-Type': 'text/plain'
          }
        }
      end

      def server_uri
        "#{Vueport.config[:server_host]}:#{Vueport.config[:server_port]}"
      end
  end
end
