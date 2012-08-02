# == Schema Information
#
# Table name: countries
#
#  name       :string(255)
#  code       :string(255)     primary key
#  created_at :datetime
#  updated_at :datetime
#  visited    :boolean         default(FALSE)
#

class Country < ActiveRecord::Base
  set_primary_key :code
  attr_accessible :name, :code, :visited

  validates_presence_of :name
  validates_presence_of :code
  validates_uniqueness_of :code, :allow_blank => true

  has_many :currencies
	has_many :trips

  accepts_nested_attributes_for :currencies, :allow_destroy => true

	def visited? current_user
		current_user.visited? self
	end
end
