module Cachescade
  module Drivers
    class SlowPoke
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

      def doze
        sleep 2
      end
    end
  end
end
