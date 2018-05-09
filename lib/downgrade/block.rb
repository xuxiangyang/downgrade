module Downgrade
  class Block
    attr_accessor :uuid
    def initialize(uuid)
      @uuid = uuid
    end

    def cache
      if Downgrade.block_switch.is_on?
        Downgrade.cache_store.fetch(cache_key) do
          yield
        end
      else
        yield
      end
    end

    def cache_key
      "downgrade:block:#{uuid}"
    end
  end
end
