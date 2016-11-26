require 'open3'
require 'shellwords'

module Vueport
  class RenderError < StandardError; end

  class NodeClient
    attr_accessor :content

    def initialize(content)
      self.content = content
    end

    def run!
      rendered_content.html_safe
    end

    private

      def rendered_content
        Open3.popen3(render_command) do |_stdin, stdout, stderr, wait_thr|
          raise(RenderError.new, stderr.read) and break unless wait_thr.value.success?
          stdout.read
        end
      end

      def render_command
        "node . --html #{Shellwords.escape(content)}"
      end
  end
end
