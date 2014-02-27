require 'cachescade/cache_layer'
require 'cachescade/drivers/in_memory'
require 'cachescade/drivers/slow_poke'

module Cachescade
  class LayerFactory
    def self.create(driver)
      case driver
      when :in_memory
        ::Cachescade::CacheLayer.new(InMemory.new)
      when :slow_poke
        ::Cachescade::CacheLayer.new(SlowPoke.new)
      else
        nil
      end
    end
  end
end
