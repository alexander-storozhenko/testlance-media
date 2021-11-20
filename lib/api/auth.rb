require 'jwt'
require 'digest'

module API
  module Auth
    extend ActiveSupport::Concern

    ALG = 'HS256'.freeze
    HMAC_SECRET = ENV['HMAC_SECRET']

    included do
      def self.authenticate!
        before do
          return error!('Forbidden', 403) if headers['Access-Token'].blank?

          decode_jwt = ->(token) { JWT.decode token, HMAC_SECRET, false, { algorithm: ALG } }

          payload = decode_jwt.call(headers['Access-Token'])&.first
          error!('Forbidden', 403) unless payload

          @user_id = payload['id']
        rescue StandardError => _e
          error!('Forbidden', 403)
        end
      end
    end
  end
end
