require 'cachescade/cache_layer'
require 'cachescade/drivers/in_memory'
require 'cachescade/drivers/slow_poke'

module Cachescade
  class LayerFactory
    CacheLayer = ::Cachescade::CacheLayer
    InMemory   = ::Cachescade::Drivers::InMemory
    SlowPoke   = ::Cachescade::Drivers::SlowPoke

    def self.create(driver)
      case driver
      when :in_memory
        CacheLayer.new(InMemory.new)
      when :slow_poke
        CacheLayer.new(SlowPoke.new)
      else
        nil
      end
    end
  end
end
