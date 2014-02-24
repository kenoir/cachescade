$: << File.dirname(__FILE__)

require "cachescade/version"
require "cachescade/layer_factory"

module Cachescade
  def self.create(drivers)
    Cachescade.new.tap do |c|
      drivers.each { |driver| c << LayerFactory.create(driver) }
    end
  end

  class Cachescade
    attr_reader :layers

    def initialize
      @layers = []
    end

    def <<(cache_layer)
      cache_layer.next_layer = @layers.last unless @layers.last.nil?
      @layers << cache_layer
    end

    def fetch(id)
      last_layer { |layer| layer.fetch(id) }
    end

    def write(id, data)
      last_layer { |layer| layer.write(id, data) }
    end

    private
    def last_layer(&block)
      @layers.last.nil? ? nil : block.call(@layers.last)
    end

  end
end
