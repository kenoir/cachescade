module Cachescade
  module Drivers
    class InMemory
      attr_accessor :hash

      def initialize
        @hash = {}
      end

      def get(id)
        @hash[id]
      end

      def put(id, data)
        @hash[id] = data
      end
    end
  end
end
