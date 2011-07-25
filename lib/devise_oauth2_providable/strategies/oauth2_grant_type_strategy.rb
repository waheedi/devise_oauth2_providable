require 'devise/strategies/base'

module Devise
  module Strategies
    class Oauth2GrantTypeStrategy < Authenticatable
      def valid?
        params[:controller] == 'oauth2/tokens' && request.post? && params[:grant_type] == grant_type
      end

      # defined by subclass
      def grant_type
      end

      def client
        @client ||= Client.where(:identifier=> params[:client_id]).first
        env['oauth2.client'] = @client
        @client
      end
      # return custom error response in accordance with the oauth spec
      # see http://tools.ietf.org/html/draft-ietf-oauth-v2-16#section-4.3
      def oauth_error!(error_code = :invalid_request, description = nil)
        body = {:error => error_code}
        body[:error_description] = description if description
        custom! [400, {'Content-Type' => 'application/json'}, [body.to_json]]
      end
    end
  end
end
