cachescade
==========

**work in progress**

JRuby Multi-Layer Cache Gem


Usage:

```rb
class CacheStub
  attr_reader :hash, :sleep_time

  def initialize(cache_speed)
    @sleep_time = cache_speed
  end

  def get(id)
    doze

    sleep @sleep_time
    (not @hash.nil?) and @hash.include?(id) ? cache_hit_for(id) : cache_miss_for(id)
  end

  def put(id, data)
    doze

    puts "cache_put #{id}"
    @hash.nil? ? (@hash = { id => data }) : @hash[id] = data
  end

  def doze
    puts "sleeping for #{@sleep_time} seconds"
    sleep @sleep_time
  end

  def cache_hit_for(id)
    puts "cache_hit #{id}"
    @hash[id]
  end

  def cache_miss_for(id)
    puts "cache_miss #{id}"
    nil
  end
end

c = Cachescade.create

c << Cachescade::CacheLayer.new(CacheStub.new(3))
c << Cachescade::CacheLayer.new(CacheStub.new(2))
c << Cachescade::CacheLayer.new(CacheStub.new(1))
```

