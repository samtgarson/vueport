module Vueport
  module Helper
    def vueport(content = nil, &block)
      content = capture(&block) if block_given?
      Vueport::Renderer.new(content).render
    end
  end
end
