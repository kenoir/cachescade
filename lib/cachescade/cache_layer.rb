module Cachescade
  class CacheLayer
    attr_reader :cache_engine
    attr_accessor :next_layer

    def initialize(cache_engine)
      @cache_engine = cache_engine
      @next_layer = terminus
    end

    def fetch(id)
      @cache_engine.get(id) || fetch_through(id)
    end

    def write(id)
      @cache_engine.put(id) && @next_layer.write(id)
    end

    private

    def fetch_through(id)
      @next_layer.fetch(id).tap do |result|
        @cache_engine.put(result) unless result.nil?
      end
    end

    def terminus
      Struct.new :layer do
        def write(id); nil; end
        def fetch(id); nil; end
      end.new
    end
  end
end
