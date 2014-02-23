cachescade
==========

JRuby Multi-Layer Cache Gem


Usage:

```rb
cache_engine_stub_miss = Struct.new :engine do
  def get(id)
    nil
  end
  def put(id); nil; end
end.new

cache_engine_stub_hit = Struct.new :engine do
  def get(id)
    1
  end
  def put(id); nil; end
end.new

l = Cachescade::CacheLayer.new(engine_fast)
c = Cachescade.create
c << cache_engine_stub_miss
c << cache_engine_stub_hit

c.fetch(1)
```

