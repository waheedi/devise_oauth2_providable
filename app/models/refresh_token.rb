require 'expirable_token'

class RefreshToken < ActiveRecord::Base
  include ExpirableToken
  self.default_lifetime = 1.month
  has_many_related :access_tokens
end
