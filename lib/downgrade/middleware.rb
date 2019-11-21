require 'rack'
module Downgrade
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      if Downgrade.middleware_switch.is_on?
        [503, { "Retry-After" => "5", "Content-Type" => "application/json; charset=utf-8" }, ['{"message": "服务器不稳定，请稍后再试"}']]
      elsif Downgrade.path_switch.is_on?
        path_cache(env)
      else
        @app.call(env)
      end
    end

    def path_cache(env)
      req = Rack::Request.new(env)
      if req.get?
        if Downgrade::Path.hit_regexp?(req.path)
          Downgrade.cache_store.fetch(request_cache_key(req), expires_in: 10.minutes) do
            status, headers, rackbody = @app.call(env)
            [status, headers, [rackbody.body]]
          end
        else
          @app.call(env)
        end
      else
        @app.call(env)
      end
    end

    def request_cache_key(req)
      "downgrade:middleware:#{req.path}:#{req['HTTP_AUTHORIZATION']}"
    end
  end
end
