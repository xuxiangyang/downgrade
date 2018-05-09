require "downgrade/version"
require 'active_support'
require 'downgrade/switch'
require 'downgrade/middleware'
require 'downgrade/path'
require 'downgrade/block'

module Downgrade
  class << self
    attr_writer :redis, :block_switch, :path_switch, :middleware_switch, :cache_store

    def path_regexps=(regexps)
      Downgrade::Path.regexps = regexps
    end

    def redis
      @redis ||= Redis.new
    end

    def block_switch
      @block_switch ||= Downgrade::Switch.new("block")
    end

    def path_switch
      @path_switch ||= Downgrade::Switch.new("path")
    end

    def middleware_switch
      @middleware_switch ||= Downgrade::Switch.new("middleware")
    end

    def cache_store
      @cache_store ||= ActiveSupport::Cache::MemoryStore.new
    end
  end
end
