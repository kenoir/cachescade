cachescade
==========

**work in progress**

JRuby Multi-Layer Cache Gem


Usage:

```rb
cache_engine_stub_miss = Struct.new :engine do
  def get(id)
    puts "CACHE MISS"
    nil
  end
  def put(id, data); nil; end
end.new

cache_engine_stub_hit = Struct.new :engine do
  def get(id)
    1
  end
  def put(id, data); nil; end
end.new

layer_miss = Cachescade::CacheLayer.new(cache_engine_stub_miss)
layer_hit  = Cachescade::CacheLayer.new(cache_engine_stub_hit)

c = Cachescade.create

c << layer_hit
c << layer_miss

c.fetch(1)
```

