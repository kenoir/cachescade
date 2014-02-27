module Cachescade
  module Drivers
    class SlowPoke
      attr_accessor :hash

      def initialize
        @hash = { 'foo' => "some fallback foo" }
      end

      def get(id)
        puts "slow_poke get #{id} - #{@hash[id]}"
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
