require 'expirable_token'

class RefreshToken 
  
  include Mongoid::Document
  
  
  include ExpirableToken
  
  field :token
  field :expires_at, :type => Time
  
  self.default_lifetime = 1.month
  has_many_related :access_tokens
end
