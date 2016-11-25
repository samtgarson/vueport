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
      Open3.popen3(render_command) do |stdin, stdout, stderr, wait_thr|
        raise(RenderError.new, stderr.read) and return unless wait_thr.value.success?
        stdout.read
      end
    end

    private

      def render_command
        "node . --html #{Shellwords.escape(content)}"
      end
  end
end
