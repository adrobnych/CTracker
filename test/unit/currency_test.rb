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

require 'test_helper'

class CurrencyTest < ActiveSupport::TestCase
  test_validates_presence_of :name, :code
end
