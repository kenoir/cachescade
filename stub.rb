require 'pry'
require 'lib/cachescade'

filo = [:slow_poke, :in_memory] # first in, last out
cache = Cachescade.create(filo)
foo = cache.fetch('foo')
puts foo
