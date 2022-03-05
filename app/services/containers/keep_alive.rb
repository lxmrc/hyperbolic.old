module Containers
  class KeepAlive
    def initialize(token:)
      @token = token
    end

    def call
      $redis.hset(token, { last_active: Time.now })
      true
    rescue Excon::Error::Socket
      false
    end

    private

    attr_reader :token
  end
end
