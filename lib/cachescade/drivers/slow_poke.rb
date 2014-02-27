module Cachescade
  module Drivers
    class SlowPoke
      attr_accessor :hash

      def initialize
        @hash = {}
      end

      def get(id)
        doze
        @hash[id]
      end

      def put(id, data)
        @hash[id] = data
      end

      private

      def doze
        puts "dozing for two seconds"
        sleep 2
      end
    end
  end
end
