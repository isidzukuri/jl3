module Base
  module Services
    class CachedData
      CACHE = Rails.cache

      def self.call(cache_key, expires_in = 1.day)
        result = CACHE.read(cache_key)
        if result.nil?
          result = yield
          CACHE.write(cache_key, result, expires_in: expires_in)
        end
        result
      end
    end
  end
end