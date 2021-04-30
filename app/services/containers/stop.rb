module Containers
  class Stop
    def initialize(container:)
      @container = container
    end

    def call
      container.stop
      container.remove(force: true)
    end

    private

    attr_reader :container
  end
end
