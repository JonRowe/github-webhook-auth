require 'rack/utils'

module Github
  module Webhook
    class Auth
      def initialize app
        @app = app
      end

      def call env
        return [401, {}, ''] unless verify_signature(env.dup)
        @app.call env
      end

    private

      def verify_signature env
        Rack::Utils.secure_compare signature(body env), env.fetch('HTTP_X_HUB_SIGNATURE','')
      end

      def body env
        env['rack.input'].rewind
        env['rack.input'].read
      end

      def signature body
        'sha1=' + OpenSSL::HMAC.hexdigest(digest, ENV['SECRET_TOKEN'], body)
      end

      def digest
        OpenSSL::Digest.new('sha1')
      end

    end
  end
end
