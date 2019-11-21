module Downgrade
  class Switch
    attr_accessor :scope, :cache_second

    def initialize(scope)
      @scope = scope
      @cache_second = 5
    end

    def turn_on(drop_percentage)
      Downgrade.redis.set(cache_key, drop_percentage)
    end

    def turn_off
      Downgrade.redis.del(cache_key)
    end

    def is_on?
      rand(100) < drop_percentage
    end

    def drop_percentage
      Downgrade::Switch.cache_store.fetch(cache_key, expires_in: self.cache_second) do
        Downgrade.redis.get(cache_key).to_f
      end
    end

    private

    def cache_key
      "downgrade:switch:#{scope}"
    end

    class << self
      def cache_store
        @cache_store ||= ActiveSupport::Cache::MemoryStore.new
      end
    end
  end
end
