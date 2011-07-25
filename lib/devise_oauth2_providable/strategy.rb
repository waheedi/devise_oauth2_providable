require 'devise/strategies/base'

module Devise
  module Strategies
    class Oauth2Providable < Authenticatable
      def valid?
        @req = Rack::OAuth2::Server::Resource::Bearer::Request.new(env)
        @req.oauth2?
      end
      def authenticate!
        @req.setup!
        token = AccessToken.valid.where(:token => @req.access_token).first
        env['oauth2.client'] = token ? token.client : nil
        resource = token ? token.user : nil
        if validate(resource)
          success! resource
        elsif !halted?
          fail(:invalid_token)
        end
      end
    end
  end
end

Warden::Strategies.add(:oauth2_providable, Devise::Strategies::Oauth2Providable)
