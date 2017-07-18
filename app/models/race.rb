class Race < ActiveRecord::Base
  has_many :reports
  has_many :users, through: :reports

  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods

  def slug
    slugify("name")
  end

end
