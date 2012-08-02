# == Schema Information
#
# Table name: trips
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  country_id :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Trip < ActiveRecord::Base
	belongs_to :user
	belongs_to :country

	validates :user, :presence => true
	validates :country, :presence => true

	scope :trips_in_month, lambda{|user_id, start, finish| includes(:country => :currencies).where(:user_id => user_id).where("trips.created_at >= ? AND trips.created_at <= ?", start, finish)}
	
end
