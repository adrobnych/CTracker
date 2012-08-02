# == Schema Information
#
# Table name: currencies
#
#  name       :string(255)
#  code       :string(255)     primary key
#  created_at :datetime
#  updated_at :datetime
#  country_id :string(255)
#

class Currency < ActiveRecord::Base
  set_primary_key :code
  attr_accessible :name, :code, :country_id

  validates_presence_of :name
  validates_presence_of :code
  validates_uniqueness_of :code, :allow_blank => true

  belongs_to :country

  def collected? current_user
    country.nil? ? false : country.visited?(current_user)
  end
end
