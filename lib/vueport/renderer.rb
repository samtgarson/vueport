require 'open3'
require 'shellwords'

module Vueport
  class RenderError < StandardError; end

  class Renderer
    WRAPPER_ID = 'vueport-wrapper'.freeze
    
    def initialize(content)
      @content = content
    end

    def render
      rendered_content.html_safe
    end

    private

      def rendered_content
        ssr_enabled? ? ssr_content : @content
      end

      def ssr_content
        Open3.popen3(render_command) do |stdin, stdout, stderr, wait_thr|
          raise(RenderError.new, stderr.read) and return unless wait_thr.value.success?
          stdout.read
        end
      end

      def render_command
        "node . --html #{Shellwords.escape("<div id='#{WRAPPER_ID}'>#{@content}</div>")}"
      end

      def ssr_enabled?
        ::Rails.configuration.vueport.ssr_enabled
      end
  end
end
