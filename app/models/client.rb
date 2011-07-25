class Client 
  
  include Mongoid::Document
  
  field :name, :type => String
  field :redirect_uri, :type => String
  field :website, :type => String
  field :identifier, :type => String
  field :secret, :type => String
  
  has_many_related :access_tokens
  has_many_related :refresh_tokens
  has_many_related :authorization_codes

  before_validation :init_identifier, :on => :create, :unless => :identifier?
  before_validation :init_secret, :on => :create, :unless => :secret?
  validates :name, :website, :redirect_uri, :secret, :presence => true
  validates :identifier, :presence => true, :uniqueness => true

  private

  def init_identifier
    self.identifier = Devise::Oauth2Providable.random_id
  end
  def init_secret
    self.secret = Devise::Oauth2Providable.random_id
  end
  

end
