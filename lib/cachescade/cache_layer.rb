module Cachescade
  class CacheLayer
    attr_reader :cache
    attr_accessor :next_layer

    def initialize(cache)
      @cache = cache
      @next_layer = terminus
    end

    def fetch(id)
      @cache.get(id) || fetch_through(id)
    end

    def write(id, data)
      Thread.new {
        @cache.put(id, data)
        @next_layer.write(id, data)
      }
    end

    private

    def fetch_through(id)
      @next_layer.fetch(id).tap do |result|
        Thread.new do
          @cache.put(id, result) unless result.nil?
        end
      end
    end

    def terminus
      Struct.new :layer do
        def write(id, data); nil; end
        def fetch(id); nil; end
      end.new
    end
  end
end
