class User < ActiveRecord::Base
  has_secure_password
  has_many :reports
  has_many :races, through: :reports

end
