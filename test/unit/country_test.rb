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

require 'test_helper'

class CountryTest < ActiveSupport::TestCase
  test_validates_presence_of :name, :code
end
