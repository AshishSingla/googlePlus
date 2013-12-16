class User < ActiveRecord::Base
  
  has_many :o_auth2_credentials, dependent: :destroy
  has_and_belongs_to_many :units
end
